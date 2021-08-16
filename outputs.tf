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
  value       = google_kms_key_ring.key_ring.self_link
}

output "keyring_resource" {
  description = "Keyring resource."
  value       = google_kms_key_ring.key_ring
}

output "keys" {
  description = "Map of key name => key self link."
  value       = local.keys_by_name
}

output "keyring_name" {
  description = "Name of the keyring."
  value       = google_kms_key_ring.key_ring.name
}

