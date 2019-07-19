# Google KMS Terraform Module

Simple Cloud KMS module that allows managing a keyring, zero or more keys in the keyring, and IAM role bindings on individual keys.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a KMS keyring in the provided project
- Create zero or more keys in the keyring
- Create IAM role bindings for owners, encrypters, decrypters

## Compatibility

This module is meant for use with Terraform 0.12. If you haven't
[upgraded][terraform-0.12-upgrade] and need a Terraform 0.11.x-compatible
version of this module, the last released version intended for Terraform 0.11.x
is [0.1.0][v0.1.0].

## Usage

Basic usage of this module is as follows:

```hcl
module "kms" {
  source  = "terraform-google-modules/kms/google"
  version = "~> 0.1"

  project_id  = "<PROJECT ID>"
  location           = "europe"
  name               = "sample-keyring"
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

[^]: (autogen_docs_start)

[^]: (autogen_docs_end)

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v2.0

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
