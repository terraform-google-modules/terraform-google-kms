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
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "location" {
  description = "Location for the keyring."
  type        = string
  default     = "global"
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

variable "key_rotation_period" {
  description = "Generate a new key every time this period passes."
  type        = string
  default     = "7776000s"
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

variable "purpose" {
  type        = string
  description = "The immutable purpose of the CryptoKey. Default value is ENCRYPT_DECRYPT. See purpose reference (https://cloud.google.com/kms/docs/reference/rest/v1/projects.locations.keyRings.cryptoKeys#CryptoKeyPurpose) for possible inputs:"
  default     = "ENCRYPT_DECRYPT"
}

variable "key_algorithm" {
  type        = string
  description = "The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs."
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
}
