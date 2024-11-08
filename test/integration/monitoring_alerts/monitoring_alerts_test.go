// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package monitoring_alert

import (
	"errors"
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/utils"
	"github.com/stretchr/testify/assert"
)

func TestMonitoringAlertKeyVersion(t *testing.T) {

	emailAddresses := []string{"email@example.com", "email2@example.com"}

	for _, monitor_all_keys_in_the_project := range []bool{
		true,
		false,
	} {

		vars := map[string]interface{}{
			"monitor_all_keys_in_the_project": monitor_all_keys_in_the_project,
			"email_addresses_to_be_notified":  emailAddresses,
		}

		kmsAlertT := tft.NewTFBlueprintTest(t,
			tft.WithVars(vars),
		)

		kmsAlertT.DefineVerify(func(assert *assert.Assertions) {
			kmsAlertT.DefaultVerify(assert)

			projectId := kmsAlertT.GetStringOutput("project_id")
			keyVersion := kmsAlertT.GetStringOutput("key")
			keyring := kmsAlertT.GetStringOutput("keyring")
			notificationChannelNames := kmsAlertT.GetJsonOutput("notification_channel_names").Array()

			assert.Len(notificationChannelNames, len(emailAddresses))
			notificationChannelEmailAddresses := []string{}
			notificationChannelStringNames := []string{}
			for _, notificationChannelName := range notificationChannelNames {
				notificationChannelStringNames = append(notificationChannelStringNames, notificationChannelName.String())
				monitoringChannel := gcloud.Runf(t, "beta monitoring channels list --project %s --filter name='%s'", projectId, notificationChannelName.String()).Array()
				assert.Len(monitoringChannel, 1)
				notificationChannelEmailAddresses = append(notificationChannelEmailAddresses, monitoringChannel[0].Get("labels.email_address").String())
			}
			assert.ElementsMatch(emailAddresses, notificationChannelEmailAddresses)

			monitoringAlerts := gcloud.Runf(t, "alpha monitoring policies list --project %s", projectId).Array()
			assert.Len(monitoringAlerts, 1)
			monitoringAlert := monitoringAlerts[0]
			alertCondition := monitoringAlerts[0].Get("conditions").Array()
			assert.Len(alertCondition, 1)

			assert.Equal("WARNING", monitoringAlert.Get("severity").String())
			assert.Equal("300s", monitoringAlert.Get("alertStrategy.notificationRateLimit.period").String())
			assert.True(monitoringAlert.Get("enabled").Bool())

			if !monitor_all_keys_in_the_project {
				time.Sleep(1 * time.Minute)
				expectedFilter := fmt.Sprintf("protoPayload.request.@type=\"type.googleapis.com/google.cloud.kms.v1.DestroyCryptoKeyVersionRequest\" AND protoPayload.request.name=~\"%s/.*\"", keyVersion)
				assert.Equal(expectedFilter, alertCondition[0].Get("conditionMatchedLog.filter").String())

				gcloud.Runf(t, fmt.Sprintf("kms keys versions destroy 1 --location us-central1 --keyring %s --key alert-key", keyring))
				utils.Poll(t, func() (bool, error) {
					alertingLogs := gcloud.Runf(t, "logging read logName:\"projects/%s/logs/monitoring.googleapis.com\" --freshness=2m --project %s", projectId, projectId).Array()
					for _, log := range alertingLogs {
						expectedLogMessage := "Log match condition fired for Cloud KMS CryptoKeyVersion"
						logMessage := log.Get("labels.verbose_message").String()
						expectedLogName := fmt.Sprintf("projects/%s/logs/monitoring.googleapis.com", projectId)
						logName := log.Get("logName").String()
						if strings.Contains(logMessage, expectedLogMessage) && strings.Contains(logName, expectedLogName) {
							// Test succeded.
							return false, nil
						}
					}
					return true, errors.New("Alert wasn't fired correctly.")
				},
					// Wait for the alert trigger to be fired into logs.
					// Timeout will occour after 20 retries of 10 seconds
					20,
					10*time.Second)
			} else {
				// Will test just the filter string when monitor_all_keys_in_the_project is true
				// in order to avoid increasing too much the test runtime
				expectedFilter := fmt.Sprintf("protoPayload.request.@type=\"type.googleapis.com/google.cloud.kms.v1.DestroyCryptoKeyVersionRequest\"")
				assert.Equal(expectedFilter, alertCondition[0].Get("conditionMatchedLog.filter").String())
			}

		})
		kmsAlertT.Test()
	}
}
