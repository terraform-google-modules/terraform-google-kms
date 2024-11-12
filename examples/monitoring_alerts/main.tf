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

/**
 * Send a warning email when a KMS key version is scheduled for destruction.
 * If multiple key versions are deleted in less than 5 minutes a single notification will be sent.
 */

locals {
  all_keys_filter   = "protoPayload.request.@type=\"type.googleapis.com/google.cloud.kms.v1.DestroyCryptoKeyVersionRequest\""
  single_key_filter = "${local.all_keys_filter} AND protoPayload.request.name=~\"${values(module.kms.keys)[0]}/.*\""
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

module "kms" {
  source  = "terraform-google-modules/kms/google"
  version = "~> 3.2"

  project_id      = var.project_id
  keyring         = "alert-keyring-${random_string.suffix.result}"
  location        = "us-central1"
  keys            = ["alert-key"]
  prevent_destroy = false
}

resource "google_monitoring_alert_policy" "main" {
  project      = var.project_id
  display_name = "KMS Key Version Destruction Alert"
  documentation {
    content = "KMS Key Version alert: one or more key versions from ${var.project_id} project were scheduled for destruction."
  }
  combiner = "OR"
  conditions {
    display_name = "Destroy condition"
    condition_matched_log {
      filter = var.monitor_all_keys_in_the_project ? local.all_keys_filter : local.single_key_filter
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }

  notification_channels = [for email_ch in google_monitoring_notification_channel.email_channel : email_ch.name]

  severity = "WARNING"
}

resource "google_monitoring_notification_channel" "email_channel" {
  for_each = toset(var.email_addresses_to_be_notified)

  project      = var.project_id
  display_name = "KMS version scheduled for destruction alert channel"
  type         = "email"
  description  = "Sends email notifications for KMS key versions scheduled for destruction alerts"

  labels = {
    email_address = each.value
  }
}
