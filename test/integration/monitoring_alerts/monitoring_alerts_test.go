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
	"github.com/tidwall/gjson"
)

func TestMonitoringAlertKeyVersion(t *testing.T) {

	TfInputs := map[bool]string{
		true:  "../../fixtures/monitoring_alerts_on_project",
		false: "../../fixtures/monitoring_alerts_specific_key",
	}

	for monitor_all_keys_in_the_project, fixture_path := range TfInputs {

		kmsAlertT := tft.NewTFBlueprintTest(t,
			tft.WithTFDir(fixture_path),
		)

		kmsAlertT.DefineVerify(func(assert *assert.Assertions) {
			kmsAlertT.DefaultVerify(assert)

			projectId := kmsAlertT.GetStringOutput("project_id")
			keyVersion := kmsAlertT.GetStringOutput("key")
			keyring := kmsAlertT.GetStringOutput("keyring")
			notificationChannelNames := kmsAlertT.GetJsonOutput("notification_channel_names").Array()

			assert.Len(notificationChannelNames, 2)
			notificationChannelEmailAddresses := []string{}
			notificationChannelStringNames := []string{}
			for _, notificationChannelName := range notificationChannelNames {
				notificationChannelStringNames = append(notificationChannelStringNames, notificationChannelName.String())
				monitoringChannel := gcloud.Runf(t, "beta monitoring channels list --project %s --filter name='%s'", projectId, notificationChannelName.String()).Array()
				assert.Len(monitoringChannel, 1)
				notificationChannelEmailAddresses = append(notificationChannelEmailAddresses, monitoringChannel[0].Get("labels.email_address").String())
			}
			assert.ElementsMatch([]string{"email@example.com", "email2@example.com"}, notificationChannelEmailAddresses)

			var expectedFilter string
			if monitor_all_keys_in_the_project {
				expectedFilter = fmt.Sprintf("protoPayload.request.@type=\"type.googleapis.com/google.cloud.kms.v1.DestroyCryptoKeyVersionRequest\"")
			} else {
				expectedFilter = fmt.Sprintf("protoPayload.request.@type=\"type.googleapis.com/google.cloud.kms.v1.DestroyCryptoKeyVersionRequest\" AND protoPayload.request.name=~\"%s/.*\"", keyVersion)
			}

			monitoringAlerts := gcloud.Runf(t, "alpha monitoring policies list --project %s", projectId).Array()
			var monitoringAlert gjson.Result
			for _, monitoringAlertLoop := range monitoringAlerts {
				conditions := monitoringAlertLoop.Get("conditions").Array()
				if len(conditions) > 0 && conditions[0].Get("conditionMatchedLog.filter").String() == expectedFilter {
					monitoringAlert = monitoringAlertLoop
					break
				}
			}
			alertCondition := monitoringAlert.Get("conditions").Array()
			assert.Len(alertCondition, 1)
			assert.Equal(expectedFilter, alertCondition[0].Get("conditionMatchedLog.filter").String())
			notificationChannels := monitoringAlert.Get("notificationChannels").Array()
			for _, notificationChannel := range notificationChannels {
				assert.Contains(notificationChannelStringNames, notificationChannel.String())
			}
			assert.Equal("WARNING", monitoringAlert.Get("severity").String())
			assert.Equal("300s", monitoringAlert.Get("alertStrategy.notificationRateLimit.period").String())
			assert.True(monitoringAlert.Get("enabled").Bool())

			if !monitor_all_keys_in_the_project {
				time.Sleep(1 * time.Minute)
				// Deleting a key will be tested just for a specific key use case in order
				// to avoid increasing too much the testing runtime.

				gcloud.Runf(t, fmt.Sprintf("kms keys versions destroy 1 --location us-central1 --keyring %s --key alert-key --project %s", keyring, projectId))
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
			}
		})
		kmsAlertT.Test()

	}
}
