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

locals {
  keys_by_name = zipmap(var.keys, [for k in var.keys : "${google_kms_key_ring.key_ring.id}/cryptoKeys/${k}"])
}

resource "google_kms_key_ring" "key_ring" {
  name     = var.keyring
  project  = var.project_id
  location = var.location
}

resource "google_kms_crypto_key" "key" {
  for_each                      = var.prevent_destroy ? { for key in var.keys : key => key } : {}
  name                          = each.key
  key_ring                      = google_kms_key_ring.key_ring.id
  rotation_period               = var.key_rotation_period
  purpose                       = var.purpose
  import_only                   = var.import_only
  skip_initial_version_creation = var.skip_initial_version_creation
  crypto_key_backend            = var.crypto_key_backend

  lifecycle {
    prevent_destroy = true
  }

  destroy_scheduled_duration = var.key_destroy_scheduled_duration

  version_template {
    algorithm        = var.key_algorithm
    protection_level = var.key_protection_level
  }

  labels = var.labels
}

resource "google_kms_crypto_key" "key_ephemeral" {
  for_each                      = var.prevent_destroy ? {} : { for key in var.keys : key => key }
  name                          = each.key
  key_ring                      = google_kms_key_ring.key_ring.id
  rotation_period               = var.key_rotation_period
  purpose                       = var.purpose
  import_only                   = var.import_only
  skip_initial_version_creation = var.skip_initial_version_creation
  crypto_key_backend            = var.crypto_key_backend

  lifecycle {
    prevent_destroy = false
  }

  destroy_scheduled_duration = var.key_destroy_scheduled_duration

  version_template {
    algorithm        = var.key_algorithm
    protection_level = var.key_protection_level
  }

  labels = var.labels
}

resource "google_kms_crypto_key_iam_binding" "owners" {
  for_each      = toset(var.set_owners_for)
  role          = "roles/owner"
  crypto_key_id = local.keys_by_name[each.key]
  members       = compact(split(",", var.owners[index(var.set_owners_for, each.key)]))
}

resource "google_kms_crypto_key_iam_binding" "decrypters" {
  for_each      = toset(var.set_decrypters_for)
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  crypto_key_id = local.keys_by_name[each.key]
  members       = compact(split(",", var.owners[index(var.decrypters, each.key)]))
}

resource "google_kms_crypto_key_iam_binding" "encrypters" {
  for_each      = toset(var.set_encrypters_for)
  role          = "roles/cloudkms.cryptoKeyEncrypter"
  crypto_key_id = local.keys_by_name[each.key]
  members       = compact(split(",", var.owners[index(var.encrypters, each.key)]))
}
