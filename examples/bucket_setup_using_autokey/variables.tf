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

variable "kms_project_id" {
  description = "The ID of the project in which kms keyring and kms keys will be provisioned by autokey."
  type        = string
}

variable "folder_id" {
  type        = string
  description = "The ID of the folder for which to configure and enable Autokey feature. Required when using Autokey."
}

variable "resource_project_id" {
  description = "The ID of the project in which to provision resources (bucket, persistent disk, etc)"
  type        = string
}

variable "bucket_location" {
  type        = string
  description = "The gcp location where storage bucket will be created"
  default     = "us-central1"
}
