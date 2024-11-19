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

package autokey_example

import (
	"context"
	"fmt"
	"io"
	"regexp"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/utils"
	"github.com/stretchr/testify/assert"
	"golang.org/x/oauth2/google"
)

func validateKeyHandleVersion(input string, projectId string, autokeyResource string) bool {
	pattern := fmt.Sprintf(`^projects/%s/locations/us-central1/keyRings/autokey/cryptoKeys/%s-(bigquery-dataset|compute-disk|storage-bucket)-.*?/cryptoKeyVersions/1$`, projectId, autokeyResource)
	regex := regexp.MustCompile(pattern)
	return regex.MatchString(input)
}

func TestAutokeyExample(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)
	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		kmsProjectId := bpt.GetStringOutput("kms_project_id")
		autokeyConfig := bpt.GetStringOutput("autokey_config_id")

		// Autokey config doesn't have a gcloud command yet. That's why we need to hit the API.
		autokeyConfigUrl := fmt.Sprintf("https://cloudkms.googleapis.com/v1/%s", autokeyConfig)

		httpClient, err := google.DefaultClient(context.Background(), "https://www.googleapis.com/auth/cloud-platform")

		if err != nil {
			t.Fatal(err.Error())
		}

		resp, err := httpClient.Get(autokeyConfigUrl)
		if err != nil {
			t.Fatal(err.Error())
		}

		defer resp.Body.Close()
		body, err := io.ReadAll(resp.Body)
		if err != nil {
			t.Fatal(err.Error())
		}

		result := utils.ParseJSONResult(t, string(body))

		// Asserting if Autokey configuration was enabled with correct kms project id
		autokeyConfigProject := result.Get("keyProject").String()
		assert.Equal(autokeyConfigProject, fmt.Sprintf("projects/%s", kmsProjectId), "autokey expected for project %s", kmsProjectId)
	})

	bpt.Test()
}
