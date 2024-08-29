# Autokey Example

This example illustrates how to use the `kms` module with [KMS Autokey](https://cloud.google.com/kms/docs/autokey-overview) feature.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autokey\_resource\_project\_id | The ID of the project for Autokey to be used (e.g: a storage project which expects to use Autokey as CMEK). | `string` | n/a | yes |
| folder\_id | The Autokey folder number for which to retrieve config. Required when using Autokey. | `string` | n/a | yes |
| location | Location for the keyring. | `string` | `"global"` | no |
| project\_id | The ID of the project in which to provision Autokey resources (autokey keyring and keyHandle keys). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| keyring | The name of the keyring. |
| keys | List of created kkey names. |
| location | The location of the keyring. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
