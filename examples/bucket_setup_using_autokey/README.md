# Autokey Example

This example illustrates how to use the `autokey` kms submodule for [KMS Autokey](https://cloud.google.com/kms/docs/autokey-overview) feature to create the bucket.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_location | The GCP location where storage bucket will be created | `string` | `"us-central1"` | no |
| folder\_id | The ID of the folder for which to configure and enable Autokey feature. | `string` | n/a | yes |
| key\_project\_id | The ID of the project in which KMS keyring and KMS keys will be provisioned by autokey. | `string` | n/a | yes |
| resource\_project\_id | The ID of the project in which to provision cloud storage bucket resource. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_keyhandle | Keyhandle configuration created for the bucket. |
| bucket\_name | Name of the bucket created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
