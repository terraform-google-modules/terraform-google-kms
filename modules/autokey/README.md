# Autokey submodule

This is a submodule built to make [KMS Autokey](https://cloud.google.com/kms/docs/autokey-overview) feature simple to be used. This submodule will create the [Autokey Config](https://cloud.google.com/kms/docs/enable-autokey#enable-autokey-folder) for an existing folder where you want to enable Autokey, set up the Cloud KMS [service agent](https://cloud.google.com/kms/docs/enable-autokey#autokey-service-agent) on an existing key project and create [Key Handles](https://cloud.google.com/kms/docs/resource-hierarchy#key_handles) for existing resource projects.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autokey\_folder\_number | The Autokey folder number used by Autokey config resource. Required when using Autokey. | `string` | n/a | yes |
| autokey\_handles | (Optional) A KeyHandle is a resource used by Autokey to auto-provision CryptoKeys for CMEK for a particular service.<br>- name: The resource name for the KeyHandle.<br>- resource\_type\_selector: Indicates the resource type that the resulting CryptoKey is meant to protect, in the following format: {SERVICE}.googleapis.com/{TYPE}. For example, storage.googleapis.com/Bucket. All Cloud KMS Autokey compatible services available at https://cloud.google.com/kms/docs/autokey-overview#compatible-services.<br>- location: The location for the KeyHandle. A full list of valid locations can be found by running gcloud kms locations list.<br>- project: The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | <pre>map(object({<br>    name                   = string<br>    resource_type_selector = string<br>    location               = string<br>    project                = string<br>  }))</pre> | `null` | no |
| project\_id | Project id where the Autokey configuration and KeyHandles will be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| autokey\_config\_id | An Autokey configuration identifier. |
| autokey\_keyhandles | A map of KeyHandles created. |
| random\_suffix | Random 4 digits suffix used in Autokey submodule. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
