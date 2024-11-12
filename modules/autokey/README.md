# Autokey submodule

This is a submodule built to make [KMS Autokey](https://cloud.google.com/kms/docs/autokey-overview) feature simple to be used. This submodule will create the [Autokey Config](https://cloud.google.com/kms/docs/enable-autokey#enable-autokey-folder) for an existing folder where you want to enable Autokey, set up the Cloud KMS [service agent](https://cloud.google.com/kms/docs/enable-autokey#autokey-service-agent) on an existing key project and create [Key Handles](https://cloud.google.com/kms/docs/resource-hierarchy#key_handles) for existing resource projects.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autokey\_folder\_number | The folder number on which autokey will be configured and enabled. Required when using Autokey. | `string` | n/a | yes |
| autokey\_kms\_project\_id | The ID of the project in which kms keyrings and keys will be provisioned by the Autokey. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| autokey\_config\_id | An Autokey configuration identifier. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
