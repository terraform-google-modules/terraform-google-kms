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
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "monitor_all_keys_in_the_project" {
  type        = bool
  description = "True for all KMS key versions under the same project to be monitored, false for only the KMS key version created in this example to be monitored. Default: false."
}

variable "email_addresses_to_be_notified" {
  type        = list(string)
  description = "Email addresses used for sending notifications to."
}

variable "location" {
  type        = string
  description = "Location to create the KMS key and keyring."
  default     = "us-central1"
}
