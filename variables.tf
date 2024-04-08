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
  description = "Project id where the keyring will be created."
  type        = string
}

# cf https://cloud.google.com/kms/docs/locations
variable "location" {
  description = "Location for the keyring."
  type        = string
}

variable "keyring" {
  description = "Keyring name."
  type        = string
}

variable "keys" {
  description = "Key names."
  type        = list(string)
  default     = []
}

variable "prevent_destroy" {
  description = "Set the prevent_destroy lifecycle attribute on keys."
  type        = bool
  default     = true
}

variable "key_destroy_scheduled_duration" {
  description = "Set the period of time that versions of keys spend in the DESTROY_SCHEDULED state before transitioning to DESTROYED."
  type        = string
  default     = null
}

variable "purpose" {
  type        = string
  description = "The immutable purpose of the CryptoKey. Default value is ENCRYPT_DECRYPT. See purpose reference (https://cloud.google.com/kms/docs/reference/rest/v1/projects.locations.keyRings.cryptoKeys#CryptoKeyPurpose) for possible inputs."
  default     = "ENCRYPT_DECRYPT"
}

variable "set_owners_for" {
  description = "Name of keys for which owners will be set."
  type        = list(string)
  default     = []
}

variable "owners" {
  description = "List of comma-separated owners for each key declared in set_owners_for."
  type        = list(string)
  default     = []
}

variable "set_encrypters_for" {
  description = "Name of keys for which encrypters will be set."
  type        = list(string)
  default     = []
}

variable "encrypters" {
  description = "List of comma-separated owners for each key declared in set_encrypters_for."
  type        = list(string)
  default     = []
}

variable "set_decrypters_for" {
  description = "Name of keys for which decrypters will be set."
  type        = list(string)
  default     = []
}

variable "decrypters" {
  description = "List of comma-separated owners for each key declared in set_decrypters_for."
  type        = list(string)
  default     = []
}

variable "key_rotation_period" {
  description = "Generate a new key every time this period passes."
  type        = string
  default     = "7776000s"
}

variable "key_algorithm" {
  type        = string
  description = "The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs."
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
}

variable "key_protection_level" {
  type        = string
  description = "The protection level to use when creating a version based on this template. Default value: \"SOFTWARE\" Possible values: [\"SOFTWARE\", \"HSM\", \"EXTERNAL\", \"EXTERNAL_VPC\"]"
  default     = "SOFTWARE"
}

variable "labels" {
  type        = map(string)
  description = "Labels, provided as a map"
  default     = {}
}

variable "import_only" {
  type        = bool
  description = "Whether these keys may contain imported versions only."
  default     = false
}

variable "skip_initial_version_creation" {
  type        = bool
  description = "If set to true, the request will create CryptoKeys without any CryptoKeyVersions."
  default     = false
}

variable "crypto_key_backend" {
  type        = string
  description = "(Optional) The resource name of the backend environment associated with all CryptoKeyVersions within this CryptoKey. The resource name is in the format 'projects//locations//ekmConnections/*' and only applies to 'EXTERNAL_VPC' keys."
  default     = null
}
