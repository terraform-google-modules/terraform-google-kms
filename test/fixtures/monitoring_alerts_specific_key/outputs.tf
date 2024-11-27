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

output "key" {
  value       = module.monitoring_alert_specific_key.key
  description = "The version of the created KMS key."
}

output "keyring" {
  value       = module.monitoring_alert_specific_key.keyring
  description = "The keyring created."
}

output "project_id" {
  value       = module.monitoring_alert_specific_key.project_id
  description = "GCP Project ID where key version was created."
}

output "notification_channel_names" {
  value       = module.monitoring_alert_specific_key.notification_channel_names
  description = "Notification channel names."
}
