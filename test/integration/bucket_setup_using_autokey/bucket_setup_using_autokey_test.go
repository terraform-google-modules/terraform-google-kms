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

package bucket_setup_using_autokey

import (
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestBucketSetupUsingAutokey(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t, tft.WithTFDir("../../fixtures/bucket_setup_using_autokey_fixture"))
	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		bucketKeyHandle := bpt.GetJsonOutput("bucket_keyhandle")
		bucketName := bpt.GetStringOutput("bucket_name")

		keyHandleKmsKey := bucketKeyHandle.Get("kms_key").String()
		op1 := gcloud.Runf(t, "storage buckets describe gs://%s", bucketName).Array()
		bucketKmsKey := op1[0].Map()["default_kms_key"].Str
		assert.True(keyHandleKmsKey != "", "Invalid KMS Key generated for bucket keyhandle")
		assert.True(bucketKmsKey == keyHandleKmsKey, "KMS Key generated for bucket keyhandle %s is not matching with kms key used in bucket %s", keyHandleKmsKey, bucketKmsKey)
	})

	bpt.Test()
}
