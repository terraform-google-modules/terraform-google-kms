/**
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "autokey" {
  source  = "terraform-google-modules/kms/google//modules/autokey"
  version = "3.1.0"

  project_id            = var.project_id
  autokey_folder_number = var.folder_id
  autokey_handles = {
    storage_bucket = {
      name                   = "bucket-key-handle",
      project                = var.autokey_resource_project_id,
      resource_type_selector = "storage.googleapis.com/Bucket",
      location               = "us-central1"
    }
    compute_disk = {
      name                   = "disk-key-handle",
      project                = var.autokey_resource_project_id,
      resource_type_selector = "compute.googleapis.com/Disk",
      location               = "us-central1"
    }
    bigquery_dataset = {
      name                   = "dataset-key-handle",
      project                = var.autokey_resource_project_id,
      resource_type_selector = "bigquery.googleapis.com/Dataset",
      location               = "us-central1"
    }
  }
}

