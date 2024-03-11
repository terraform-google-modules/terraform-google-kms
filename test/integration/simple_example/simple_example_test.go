// Copyright 2022 Google LLC
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

package simple_example

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestSimpleExample(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)
	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		projectId := bpt.GetStringOutput("project_id")
		keyring := bpt.GetStringOutput("keyring")
		location := bpt.GetStringOutput("location")
		keys := [2]string{"one", "two"}

		op := gcloud.Runf(t, "--project=%s kms keyrings list --location %s --sort-by ~createTime", projectId, location).Array()[0].Get("name")
		assert.Contains(op.String(), fmt.Sprintf("projects/%s/locations/%s/keyRings/%s", projectId, location, keyring), "Contains KeyRing")

		op1 := gcloud.Runf(t, "kms keys list --project=%s --keyring %s --location %s", projectId, keyring, location).Array()
		for index, element := range op1 {
			assert.Equal(element.Get("primary").Map()["name"].Str, fmt.Sprintf("projects/%s/locations/%s/keyRings/%s/cryptoKeys/%s/cryptoKeyVersions/1", projectId, location, keyring, keys[index]), "Contains Keys")
		}
	})

	bpt.Test()
}
