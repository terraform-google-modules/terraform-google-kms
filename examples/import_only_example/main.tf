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

module "kms" {
  source = "github.com/romanini-ciandt/terraform-google-kms?ref=11b64a6b1829ddc8ef9cf200d00565064fbd9e61"

  # TODO: Update with the following source when v2.4 is released
  # source  = "terraform-google-modules/kms/google"
  # version = "~> 2.4"

  project_id = var.project_id
  keyring    = var.keyring
  location   = var.location
  keys       = var.keys
  # keys can be destroyed by Terraform
  prevent_destroy               = false
  import_only                   = var.import_only
  skip_initial_version_creation = var.skip_initial_version_creation
  key_rotation_period           = var.key_rotation_period
  purpose                       = var.purpose
  key_algorithm                 = var.key_algorithm
}

