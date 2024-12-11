# Autokey Example

This example illustrates how to setup the `autokey` kms submodule for [KMS Autokey](https://cloud.google.com/kms/docs/autokey-overview) feature.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| folder\_id | The ID of the folder for which to configure and enable Autokey feature. | `string` | n/a | yes |
| kms\_project\_id | The ID of the project in which KMS keyring and KMS keys will be provisioned by autokey. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| autokey\_config\_id | An Autokey configuration identifier. |
| kms\_project\_id | The ID of the project in which kms keyring and kms keys will be provisioned by autokey. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
