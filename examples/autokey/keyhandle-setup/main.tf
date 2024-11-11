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



resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "google_kms_key_handle" "bucket_keyhandle" {
  provider = google-beta

  project                = var.resource_project_id
  name                   = "${var.bucket_name_prefix}-${random_string.suffix.result}"
  location               = var.bucket_location
  resource_type_selector = var.resource_type_selector

  lifecycle {
    ignore_changes = [name]
  }
}

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "8.0"

  name       = "${var.bucket_name_prefix}-${random_string.suffix.result}"
  project_id = var.resource_project_id
  location   = var.bucket_location
  encryption = {
    default_kms_key_name = resource.google_kms_key_handle.bucket_keyhandle.kms_key
  }

  depends_on = [resource.google_kms_key_handle.bucket_keyhandle]
}