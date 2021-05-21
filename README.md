# Google KMS Terraform Module

Simple Cloud KMS module that allows managing a keyring, zero or more keys in the keyring, and IAM role bindings on individual keys.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a KMS keyring in the provided project
- Create zero or more keys in the keyring
- Create IAM role bindings for owners, encrypters, decrypters

## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v1.2.0](https://registry.terraform.io/modules/terraform-google-modules/-kms/google/v1.2.0).

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

  key_opts = [
    {
      key = "foo"
      rotation_period = "100000s"
    },
  ]

  acl = [
    {
      key = "foo"
      owners = ["group:one@example.com","user:two@example.com"]
    },
    {
      key = "spam"
      encrypters = ["serviceAccount:one@example.com"]
    }
  ]
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acl | Access control list for the managed keys. | `list(any)` | `[]` | no |
| existing\_keyring | Use existing keyring | `bool` | `false` | no |
| key\_opts | Specifies key specific options. | `list(any)` | `[]` | no |
| keyring | Keyring name. | `string` | n/a | yes |
| keys | Key names. | `list(string)` | `[]` | no |
| location | Location for the keyring. | `string` | n/a | yes |
| prevent\_destroy | Set the prevent\_destroy lifecycle attribute on keys. | `bool` | `true` | no |
| project\_id | Project id where the keyring will be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| acl | Access control list provided. |
| existing\_keyring | Existing keyring is used, i.e. keyring has been created. |
| keyring\_id | Self link of the keyring. |
| keyring\_name | Name of the keyring. |
| keyring\_project | Project of the keyring. |
| keys | Map of key name => id. |
| kms\_keys | Managed kms keys details. |
| location | Location of the keyring. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
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
