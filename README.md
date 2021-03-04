# Google KMS Terraform Module

Simple Cloud KMS module that allows managing a keyring, zero or more keys in the keyring, and IAM role bindings on individual keys.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a KMS keyring in the provided project
- Create zero or more keys in the keyring
- Create IAM role bindings for owners, encrypters, decrypters

## Compatibility

This module is meant for use with Terraform 0.12. If you haven't upgraded and need a Terraform 0.11.x-compatible
version of this module, the last released version intended for Terraform 0.11.x
is [v0.1.0](https://registry.terraform.io/modules/terraform-google-modules/kms/google/0.1.0).

## Usage

Basic usage of this module is as follows:

```hcl
module "kms" {
  source  = "terraform-google-modules/kms/google"
  version = "~> 1.2"

  project_id         = "<PROJECT ID>"
  location           = "europe"
  keyring            = "sample-keyring"
  keys               = ["foo", "spam"]
  set_owners_for     = ["foo", "spam"]
  owners = [
    "group:one@example.com,group:two@example.com",
    "group:one@example.com",
  ]
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| decrypters | List of comma-separated owners for each key declared in set_decrypters_for. | list(string) | `<list>` | no |
| encrypters | List of comma-separated owners for each key declared in set_encrypters_for. | list(string) | `<list>` | no |
| key\_algorithm | The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs. | string | `"GOOGLE_SYMMETRIC_ENCRYPTION"` | no |
| key\_protection\_level | The protection level to use when creating a version based on this template. Default value: "SOFTWARE" Possible values: ["SOFTWARE", "HSM"] | string | `"SOFTWARE"` | no |
| key\_rotation\_period |  | string | `"100000s"` | no |
| keyring | Keyring name. | string | n/a | yes |
| keys | Key names. | list(string) | `<list>` | no |
| labels | Labels, provided as a map | map(string) | `<map>` | no |
| location | Location for the keyring. | string | n/a | yes |
| owners | List of comma-separated owners for each key declared in set_owners_for. | list(string) | `<list>` | no |
| prevent\_destroy | Set the prevent_destroy lifecycle attribute on keys. | string | `"true"` | no |
| project\_id | Project id where the keyring will be created. | string | n/a | yes |
| purpose | The immutable purpose of the CryptoKey. Possible values are ENCRYPT_DECRYPT, ASYMMETRIC_SIGN, and ASYMMETRIC_DECRYPT | string | `ENCRYPT_DECRYPT` | no |
| set\_decrypters\_for | Name of keys for which decrypters will be set. | list(string) | `<list>` | no |
| set\_encrypters\_for | Name of keys for which encrypters will be set. | list(string) | `<list>` | no |
| set\_owners\_for | Name of keys for which owners will be set. | list(string) | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| keyring | Self link of the keyring. |
| keyring\_name | Name of the keyring. |
| keyring\_resource | Keyring resource. |
| keys | Map of key name => key self link. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

A service account with one of the following roles must be used to provision
the resources of this module:

- Cloud KMS Admin: `roles/cloudkms.admin` or
- Owner: `roles/owner`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Key Management Service: `cloudkms.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
