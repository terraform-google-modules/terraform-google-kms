# Simple Example

This example illustrates how to use the `kms` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| import\_only | Whether these keys may contain imported versions only. | `bool` | `false` | no |
| key\_algorithm | The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs. | `string` | `"GOOGLE_SYMMETRIC_ENCRYPTION"` | no |
| key\_rotation\_period | Generate a new key every time this period passes. | `string` | `"7776000s"` | no |
| keyring | Keyring name. | `string` | n/a | yes |
| keys | Key names. | `list(string)` | `[]` | no |
| location | Location for the keyring. | `string` | `"global"` | no |
| project\_id | The ID of the project in which to provision resources. | `string` | n/a | yes |
| purpose | Default value is ENCRYPT\_DECRYPT. See purpose reference (https://cloud.google.com/kms/docs/reference/rest/v1/projects.locations.keyRings.cryptoKeys#CryptoKeyPurpose) for possible inputs: | `string` | `"ENCRYPT_DECRYPT"` | no |
| skip\_initial\_version\_creation | If set to true, the request will create CryptoKeys without any CryptoKeyVersions. | `bool` | `false` | no |

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
