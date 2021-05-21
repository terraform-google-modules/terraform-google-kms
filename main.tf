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

resource "google_kms_key_ring" "key_ring" {
  count    = var.existing_keyring ? 0 : 1
  name     = var.keyring
  project  = var.project_id
  location = var.location
}

data "google_kms_key_ring" "key_ring" {
  count    = var.existing_keyring ? 1 : 0
  name     = var.keyring
  project  = var.project_id
  location = var.location
}

resource "google_kms_crypto_key" "key" {
  for_each = local.keys
  name     = each.key

  key_ring        = local.keyring_id
  rotation_period = each.value.rotation_period

  lifecycle {
    prevent_destroy = true
  }

  version_template {
    algorithm        = each.value.algorithm
    protection_level = each.value.protection_level
  }

  labels = each.value.labels
}

resource "google_kms_crypto_key" "ephemeral_key" {
  for_each = local.ephemeral_keys
  name     = each.key

  key_ring        = local.keyring_id
  rotation_period = each.value.rotation_period

  lifecycle {
    prevent_destroy = false
  }

  version_template {
    algorithm        = each.value.algorithm
    protection_level = each.value.protection_level
  }

  labels = each.value.labels
}

resource "google_kms_crypto_key_iam_member" "iam_rule" {
  for_each      = local.iam_rules
  crypto_key_id = each.value.key_id
  role          = each.value.role
  member        = each.value.identity
}
