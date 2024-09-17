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

output "project_id" {
  value = module.project_ci_kms.project_id
}

output "autokey_resource_project_id" {
  value = module.autokey_resource_project.project_id
}

output "autokey_resource_project_number" {
  value = module.autokey_resource_project.project_number
}

output "sa_key" {
  value     = google_service_account_key.int_test.private_key
  sensitive = true
}

output "folder_id" {
  value = split("/", google_folder.test_folder.id)[1]
}
