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

variable "project_id" {
  description = "The ID of the project in which to provision Autokey resources (autokey keyring and keyHandle keys)."
  type        = string
}

variable "autokey_resource_project_id" {
  description = "The ID of the project for Autokey to be used (e.g: a storage project which expects to use Autokey as CMEK)."
  type        = string
}

variable "location" {
  description = "Location for the autokey keyring."
  type        = string
  default     = "us-central1"
}

variable "folder_id" {
  type        = string
  description = "The Autokey folder number for which to retrieve config. Required when using Autokey."
}

