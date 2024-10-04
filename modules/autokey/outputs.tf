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

output "autokey_config_id" {
  description = "An Autokey configuration identifier."
  value       = var.autokey_folder_number != null ? google_kms_autokey_config.primary[0].id : ""
}

output "autokey_keyhandles" {
  description = "A map of KeyHandles created."
  value       = local.create_autokey_key_handles ? google_kms_key_handle.primary : {}
}

output "random_suffix" {
  description = "Random 4 digits suffix used in Autokey submodule."
  value       = random_string.suffix.result
}
