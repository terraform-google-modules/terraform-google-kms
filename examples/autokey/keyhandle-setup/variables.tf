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

variable "resource_project_id" {
  description = "The ID of the project in which to provision resources (bucket, persistent disk, etc)"
  type        = string
}

variable "bucket_name_prefix" {
  type        = string
  description = "The storage bucket created will have name {bucket_name_prefix}-{random-suffix}"
}

variable "resource_type_selector" {
  type        = string
  description = "The resource type selector for bucket"
} 

variable "bucket_location" {
  type        = string
  description = "The gcp location where storage bucket will be created"
}
