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
  description = "Project id where the Autokey configuration and KeyHandles will be created."
  type        = string
}

variable "autokey_folder_number" {
  type        = string
  description = "The Autokey folder number used by Autokey config resource. Required when using Autokey."
  default     = null
}

variable "autokey_handles" {
  type = map(object({
    name                   = string
    resource_type_selector = string
    location               = string
    project                = string
  }))
  description = <<-EOF
    "(Optional) A KeyHandle is a resource used by Autokey to auto-provision CryptoKeys for CMEK for a particular service.
    - name: The resource name for the KeyHandle.
    - resource_type_selector: Indicates the resource type that the resulting CryptoKey is meant to protect, in the following format: {SERVICE}.googleapis.com/{TYPE}. For example, storage.googleapis.com/Bucket. All Cloud KMS Autokey compatible services available at https://cloud.google.com/kms/docs/autokey-overview#compatible-services.
    - location: The location for the KeyHandle. A full list of valid locations can be found by running gcloud kms locations list.
    - project: The ID of the project in which the resource belongs. If it is not provided, the provider project is used.
  EOF
  default     = null
}
