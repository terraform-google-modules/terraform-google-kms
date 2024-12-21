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
module "bucket_setup_using_autokey_fixture" {
  source              = "../../../examples/bucket_setup_using_autokey"
  key_project_id      = var.project_id
  folder_id           = var.folder_id
  resource_project_id = var.resource_project_id
  bucket_location     = var.bucket_location
}
