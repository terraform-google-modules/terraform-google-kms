# Import Only Example

This example illustrates how to use the `kms` module when you want to create a CryptoKey with no CryptoKeyVersion in order to import the key material.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The ID of the project in which to provision resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| keyring | The name of the keyring. |
| keys | List of created kkey names. |
| location | The location of the keyring. |
| project\_id | The ID of the project in which resources are provisioned. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
