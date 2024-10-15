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

resource "google_kms_autokey_config" "primary" {
  count    = var.autokey_folder_number != null ? 1 : 0
  provider = google-beta

  folder      = var.autokey_folder_number
  key_project = "projects/${var.project_id}"
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "google_kms_key_handle" "primary" {
  for_each = local.create_autokey_key_handles ? var.autokey_handles : tomap({})
  provider = google-beta

  project                = each.value.project
  name                   = "${each.value.name}-${random_string.suffix.result}"
  location               = each.value.location
  resource_type_selector = each.value.resource_type_selector

  lifecycle {
    ignore_changes = [name]
  }

  depends_on = [time_sleep.wait_srv_acc_permissions]
}
