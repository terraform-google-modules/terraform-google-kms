# Autokey Example

This example illustrates how to use the `autokey` kms submodule for [KMS Autokey](https://cloud.google.com/kms/docs/autokey-overview) feature to create the bucket.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_location | The gcp location where storage bucket will be created | `string` | `"us-central1"` | no |
| folder\_id | The ID of the folder for which to configure and enable Autokey feature. Required when using Autokey. | `string` | n/a | yes |
| kms\_project\_id | The ID of the project in which kms keyring and kms keys will be provisioned by autokey. | `string` | n/a | yes |
| resource\_project\_id | The ID of the project in which to provision resources (bucket, persistent disk, etc) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_keyhandle | An Autokey configuration identifier. |
| bucket\_name | A map of KeyHandles created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
