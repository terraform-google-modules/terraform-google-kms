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

variable "project_id" {
  type        = string
  description = "Project id where the keyring will be created."
}

# cf https://cloud.google.com/kms/docs/locations
variable "location" {
  type        = string
  description = "Location for the keyring."
}

variable "keyring" {
  type        = string
  description = "Keyring name."
}

variable "keys" {
  type        = list(string)
  description = "Key names."
  default     = []
}

variable "set_owners_for" {
  type        = list(string)
  description = "Name of keys for which owners will be set."
  default     = []
}

variable "owners" {
  type        = list(string)
  description = "List of comma-separated owners for each key declared in set_owners_for."
  default     = []
}

variable "set_encrypters_for" {
  type        = list(string)
  description = "Name of keys for which encrypters will be set."
  default     = []
}

variable "encrypters" {
  type        = list(string)
  description = "List of comma-separated owners for each key declared in set_encrypters_for."
  default     = []
}

variable "set_decrypters_for" {
  type        = list(string)
  description = "Name of keys for which decrypters will be set."
  default     = []
}

variable "decrypters" {
  type        = list(string)
  description = "List of comma-separated owners for each key declared in set_decrypters_for."
  default     = []
}

variable "key_rotation_period" {
  type    = string
  default = "100000s"
}

