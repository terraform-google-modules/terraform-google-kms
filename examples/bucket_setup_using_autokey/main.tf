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
  source = "terraform-google-modules/terraform-google-kms/google//modules/autokey"
  version = "~> 4.0"

  autokey_kms_project_id = var.kms_project_id
  autokey_folder_number  = var.folder_id
}

# Wait delay for autokey configuration.
resource "time_sleep" "wait_autokey_config" {
  create_duration = "20s"
  depends_on      = [module.autokey]
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "google_kms_key_handle" "bucket_keyhandle" {
  provider               = google-beta
  name                   = "${var.resource_project_id}-keyhandle-${random_string.suffix.result}"
  project                = var.resource_project_id
  location               = var.bucket_location
  resource_type_selector = "storage.googleapis.com/Bucket"

  lifecycle {
    ignore_changes = [name]
  }
  depends_on = [time_sleep.wait_autokey_config]
}

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 9.0"

  name       = "${var.resource_project_id}-bucket-${random_string.suffix.result}"
  project_id = var.resource_project_id
  location   = var.bucket_location
  encryption = {
    default_kms_key_name = resource.google_kms_key_handle.bucket_keyhandle.kms_key
  }

  depends_on = [resource.google_kms_key_handle.bucket_keyhandle]
}
