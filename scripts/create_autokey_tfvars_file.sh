#!/bin/bash

# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

echo ----------------------------------------------
echo Starting terraform.tfvars file creation
echo ----------------------------------------------

echo "
project_id            = $AUTOKEY_KMS_PROJECT_ID
autokey_folder_number = \"$AUTOKEY_FOLDER_NUMBER\"
autokey_handles = {
" > terraform.tfvars

if [ -n "$AUTOKEY_BQ_KEY_HANDLE_NAME" ]; then
  echo "
    bq_dataset = {
        name                   = \"$AUTOKEY_BQ_KEY_HANDLE_NAME\",
        project                = \"$AUTOKEY_BQ_KEY_HANDLE_PROJECT\",
        resource_type_selector = \"bigquery.googleapis.com/Dataset\",
        location               = \"$AUTOKEY_BQ_KEY_HANDLE_LOCATION\"
    },
" >> terraform.tfvars
fi
if [ -n "$AUTOKEY_DISK_KEY_HANDLE_NAME" ]; then
  echo "
    compute_disk = {
        name                   = \"$AUTOKEY_DISK_KEY_HANDLE_NAME\",
        project                = \"$AUTOKEY_DISK_KEY_HANDLE_PROJECT\",
        resource_type_selector = \"compute.googleapis.com/Disk\",
        location               = \"$AUTOKEY_DISK_KEY_HANDLE_LOCATION\"
    },
" >> terraform.tfvars
fi
if [ -n "$AUTOKEY_DISK_KEY_HANDLE_NAME" ]; then
  echo "
    gcs_bucket = {
        name                   = \"$AUTOKEY_GCS_KEY_HANDLE_NAME\",
        project                = \"$AUTOKEY_GCS_KEY_HANDLE_PROJECT\",
        resource_type_selector = \"storage.googleapis.com/Bucket\",
        location               = \"$AUTOKEY_GCS_KEY_HANDLE_LOCATION\"
    },
" >> terraform.tfvars
fi

echo "
}
" >> terraform.tfvars

echo ----------------------------------------------
echo terraform.tfvars file created
echo ----------------------------------------------
