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
echo Getting Autokey config and project
echo ----------------------------------------------
AUTOKEY_FOLDER_NUMBER=$(terraform output -raw autokey_config | cut -d'/' -f2)
export AUTOKEY_FOLDER_NUMBER
AUTOKEY_KMS_PROJECT_ID=$(echo "module.autokey.key_project_id" | terraform console)
export AUTOKEY_KMS_PROJECT_ID
echo AUTOKEY_FOLDER_NUMBER: "$AUTOKEY_FOLDER_NUMBER"
echo AUTOKEY_KMS_PROJECT_ID: "$AUTOKEY_KMS_PROJECT_ID"
echo ----------------------------------------------
echo Getting Bigquery Dataset KeyHandle
echo ----------------------------------------------
AUTOKEY_BQ_KEY_HANDLE_PROJECT=$(terraform output -raw bq_key_handle | cut -d'/' -f2)
export AUTOKEY_BQ_KEY_HANDLE_PROJECT
AUTOKEY_BQ_KEY_HANDLE_LOCATION=$(terraform output -raw bq_key_handle | cut -d'/' -f4)
export AUTOKEY_BQ_KEY_HANDLE_LOCATION
AUTOKEY_BQ_KEY_HANDLE_NAME=$(terraform output -raw bq_key_handle | cut -d'/' -f6)
export AUTOKEY_BQ_KEY_HANDLE_NAME
echo AUTOKEY_BQ_KEY_HANDLE_PROJECT: "$AUTOKEY_BQ_KEY_HANDLE_PROJECT"
echo AUTOKEY_BQ_KEY_HANDLE_LOCATION: "$AUTOKEY_BQ_KEY_HANDLE_LOCATION"
echo AUTOKEY_BQ_KEY_HANDLE_NAME: "$AUTOKEY_BQ_KEY_HANDLE_NAME"
echo ----------------------------------------------
echo Getting Compute Disk KeyHandle
echo ----------------------------------------------
AUTOKEY_DISK_KEY_HANDLE_PROJECT=$(terraform output -raw disk_key_handle | cut -d'/' -f2)
export AUTOKEY_DISK_KEY_HANDLE_PROJECT
AUTOKEY_DISK_KEY_HANDLE_LOCATION=$(terraform output -raw disk_key_handle | cut -d'/' -f4)
export AUTOKEY_DISK_KEY_HANDLE_LOCATION
AUTOKEY_DISK_KEY_HANDLE_NAME=$(terraform output -raw disk_key_handle | cut -d'/' -f6)
export AUTOKEY_DISK_KEY_HANDLE_NAME
echo AUTOKEY_DISK_KEY_HANDLE_PROJECT: "$AUTOKEY_DISK_KEY_HANDLE_PROJECT"
echo AUTOKEY_DISK_KEY_HANDLE_LOCATION: "$AUTOKEY_DISK_KEY_HANDLE_LOCATION"
echo AUTOKEY_DISK_KEY_HANDLE_NAME: "$AUTOKEY_DISK_KEY_HANDLE_NAME"
echo ----------------------------------------------
echo Getting Storage Bucket KeyHandle
echo ----------------------------------------------
AUTOKEY_GCS_KEY_HANDLE_PROJECT=$(terraform output -raw gcs_key_handle | cut -d'/' -f2)
export AUTOKEY_GCS_KEY_HANDLE_PROJECT
AUTOKEY_GCS_KEY_HANDLE_LOCATION=$(terraform output -raw gcs_key_handle | cut -d'/' -f4)
export AUTOKEY_GCS_KEY_HANDLE_LOCATION
AUTOKEY_GCS_KEY_HANDLE_NAME=$(terraform output -raw gcs_key_handle | cut -d'/' -f6)
export AUTOKEY_GCS_KEY_HANDLE_NAME
echo AUTOKEY_GCS_KEY_HANDLE_PROJECT: "$AUTOKEY_GCS_KEY_HANDLE_PROJECT"
echo AUTOKEY_GCS_KEY_HANDLE_LOCATION: "$AUTOKEY_GCS_KEY_HANDLE_LOCATION"
echo AUTOKEY_GCS_KEY_HANDLE_NAME: "$AUTOKEY_GCS_KEY_HANDLE_NAME"
