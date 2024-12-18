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
  value       = module.autokey_setup_fixture.autokey_config_id
}

output "kms_project_id" {
  description = "The ID of the project in which KMS keyring and KMS keys will be provisioned by autokey."
  value       = var.project_id
}
