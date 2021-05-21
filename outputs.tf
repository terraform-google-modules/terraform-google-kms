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

output "existing_keyring" {
  description = "Existing keyring is used, i.e. keyring has been created."
  value       = var.existing_keyring
}

output "keys" {
  description = "Map of key name => id."
  value       = { for key in local.crypto_keys : key.name => key.id }
}

output "location" {
  description = "Location of the keyring."
  value       = var.location
}

output "keyring_project" {
  description = "Project of the keyring."
  value       = var.project_id
}

output "keyring_id" {
  description = "Self link of the keyring."
  value       = local.keyring_self_link
}

output "keyring_self_link" {
  description = "Self link of the keyring."
  value       = local.keyring_self_link
}

output "keyring_name" {
  description = "Name of the keyring."
  value       = var.keyring
}

output "acl" {
  description = "Access control list provided."
  value = [for rule in var.acl :
    merge(rule, { key_id = local.crypto_keys[rule.key].id })
  ]
}

output "kms_keys" {
  description = "Managed kms keys details."
  value = { for k, v in local.crypto_keys : k => {
    id              = v.id
    key_ring        = v.key_ring
    name            = v.name
    purpose         = v.purpose
    rotation_period = v.rotation_period
  } }
}
