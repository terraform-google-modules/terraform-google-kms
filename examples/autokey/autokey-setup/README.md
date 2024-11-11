# Autokey Example

This example illustrates how to setup the `autokey` kms submodule for [KMS Autokey](https://cloud.google.com/kms/docs/autokey-overview) feature.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autokey\_resource\_project\_id | The ID of the project for Autokey to be used (e.g: a storage project which expects to use Autokey as CMEK). | `string` | n/a | yes |
| folder\_id | The Autokey folder number used by Autokey config resource. Required when using Autokey. | `string` | n/a | yes |
| project\_id | The ID of the project in which to provision Autokey resources (autokey keyring and keyHandle keys). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| autokey\_config\_id | An Autokey configuration identifier. |
| autokey\_keyhandles | A map of KeyHandles created. |
| autokey\_project\_id | Project used for autokey. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
