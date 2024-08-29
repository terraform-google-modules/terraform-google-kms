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

locals {
  create_autokey_key_handles = var.autokey_folder_number != null && var.autokey_handles != null
}

resource "google_kms_autokey_config" "main" {
  count    = var.autokey_folder_number != null ? 1 : 0
  provider = google-beta

  folder      = var.autokey_folder_number
  key_project = "projects/${var.project_id}"
}

#Create KMS Service Agent
resource "google_project_service_identity" "kms_service_agent" {
  count    = local.create_autokey_key_handles ? 1 : 0
  provider = google-beta

  service = "cloudkms.googleapis.com"
  project = data.google_project.kms_project.number
}

# Wait delay after creating service agent.
resource "time_sleep" "wait_service_agent" {
  count = local.create_autokey_key_handles ? 1 : 0

  create_duration = "10s"
  depends_on      = [google_project_service_identity.kms_service_agent]
}

data "google_project" "kms_project" {
  project_id = var.project_id
}

#Grant the KMS Service Agent the Cloud KMS Admin role
resource "google_project_iam_member" "autokey_project_admin" {
  count    = local.create_autokey_key_handles ? 1 : 0
  provider = google-beta

  project    = var.project_id
  role       = "roles/cloudkms.admin"
  member     = "serviceAccount:service-${data.google_project.kms_project.number}@gcp-sa-cloudkms.iam.gserviceaccount.com"
  depends_on = [time_sleep.wait_service_agent]
}

# Wait delay after granting IAM permissions
resource "time_sleep" "wait_srv_acc_permissions" {
  count = local.create_autokey_key_handles ? 1 : 0

  create_duration = "10s"
  depends_on      = [google_project_iam_member.autokey_project_admin]
}

resource "random_string" "suffix" {
  count = local.create_autokey_key_handles ? 1 : 0

  length  = 4
  special = false
  upper   = false
}

resource "google_kms_key_handle" "main" {
  for_each = local.create_autokey_key_handles ? var.autokey_handles : tomap({})
  provider = google-beta

  project                = each.value.project
  name                   = "${each.value.name}-${random_string.suffix[0].result}"
  location               = each.value.location
  resource_type_selector = each.value.resource_type_selector

  depends_on = [time_sleep.wait_srv_acc_permissions]
}
