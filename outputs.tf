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

output "keyring" {
  description = "Self link of the keyring."
  value       = google_kms_key_ring.key_ring.id

  # The grants are important to the key be ready to use.
  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.decrypters,
    google_kms_crypto_key_iam_binding.encrypters,
  ]
}

output "keyring_resource" {
  description = "Keyring resource."
  value       = google_kms_key_ring.key_ring

  # The grants are important to the key be ready to use.
  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.decrypters,
    google_kms_crypto_key_iam_binding.encrypters,
  ]
}

output "keys" {
  description = "Map of key name => key self link."
  value       = local.keys_by_name

  # The grants are important to the key be ready to use.
  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.decrypters,
    google_kms_crypto_key_iam_binding.encrypters,
  ]
}

output "keyring_name" {
  description = "Name of the keyring."
  value       = google_kms_key_ring.key_ring.name

  # The grants are important to the key be ready to use.
  depends_on = [
    google_kms_crypto_key_iam_binding.owners,
    google_kms_crypto_key_iam_binding.decrypters,
    google_kms_crypto_key_iam_binding.encrypters,
  ]
}

output "key_id_list" {
  description = "The list of the crypto key IDs."
  value       = concat(google_kms_crypto_key.key[*].id, google_kms_crypto_key.key_ephemeral[*].id)
}
