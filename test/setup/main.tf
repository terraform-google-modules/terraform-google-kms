/**
 * Copyright 2018 Google LLC
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
  length  = 6
  special = false
  upper   = false
}

resource "google_folder" "test_folder" {
  display_name = "test_kms_fldr_${random_string.suffix.result}"
  parent       = "folders/${var.folder_id}"
}

module "project_ci_kms" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.0"

  name              = "ci-kms-module"
  random_project_id = "true"
  org_id            = var.org_id
  folder_id         = google_folder.test_folder.folder_id
  billing_account   = var.billing_account

  activate_apis = [
    "cloudkms.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com"
  ]

  activate_api_identities = [{
    api = "cloudkms.googleapis.com"
    roles = [
      "roles/cloudkms.admin"
    ]
  }]
}

module "autokey_resource_project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.0"

  name              = "autokey-resource"
  random_project_id = "true"
  org_id            = var.org_id
  folder_id         = google_folder.test_folder.folder_id
  billing_account   = var.billing_account

  activate_apis = [
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]
}
