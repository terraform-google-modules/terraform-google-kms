
provider "google" {
  version = "< 4.0"
}

/* provider "google-beta" {
  version = ">= 3.29.0, < 4.0.0"
} */

resource "google_kms_key_ring" key_ring {
  count    = var.existing_keyring ? 0 : 1
  name     = var.keyring
  project  = var.project_id
  location = var.location
}

data "google_kms_key_ring" key_ring {
  count    = var.existing_keyring ? 1 : 0
  name     = var.keyring
  project  = var.project_id
  location = var.location
}

resource "google_kms_crypto_key" "key" {
  for_each = local.keys
  name     = each.key

  key_ring        = local.keyring_self_link
  rotation_period = each.value.rotation_period

  lifecycle {
    prevent_destroy = false
  }

  version_template {
    algorithm        = each.value.algorithm
    protection_level = each.value.protection_level
  }

  labels = each.value.labels
}

resource "google_kms_crypto_key" ephemeral_key {
  for_each = local.ephemeral_keys
  name     = each.key

  key_ring        = local.keyring_self_link
  rotation_period = each.value.rotation_period

  lifecycle {
    prevent_destroy = false
  }

  version_template {
    algorithm        = each.value.algorithm
    protection_level = each.value.protection_level
  }

  labels = each.value.labels
}

resource "google_kms_crypto_key_iam_member" iam_rule {
  for_each      = local.iam_rules
  crypto_key_id = each.value.key_id
  role          = each.value.role
  member        = each.value.identity
}
