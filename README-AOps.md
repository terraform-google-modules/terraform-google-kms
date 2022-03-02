## Google KMS Module : Updates by ActiveOps

---
https://registry.terraform.io/modules/terraform-google-modules/kms/google  
https://github.com/terraform-google-modules/terraform-google-kms
---
### Updates
Updated the based module to add a variable for "purpose" allowing you to update from the default of ENCRYPT_DECRYPT.

The files that were updated are:

* `main.tf` to include `purpose = var.key_purpose` under `google_kms_crypto_key`:

```hcl
resource "google_kms_crypto_key" "key_ephemeral" {
  count           = var.prevent_destroy ? 0 : length(var.keys)
  name            = var.keys[count.index]
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = var.key_rotation_period
  purpose         = var.key_purpose

  lifecycle {
    prevent_destroy = false
    }

  version_template {
    algorithm        = var.key_algorithm
    protection_level = var.key_protection_level
  }

  labels = var.labels
}
```

* `variables.tf` to include the variable for `kms_purpose`:

```hcl
  variable "key_purpose" {
    type        = string
    description = "The purpose of this CryptoKey. Default value is ENCRYPT_DECRYPT. Possible values are \"ENCRYPT_DECRYPT\", \"ASYMMETRIC_SIGN\", and \"ASYMMETRIC_DECRYPT\"."
    default     = "ENCRYPT_DECRYPT"
  }
```