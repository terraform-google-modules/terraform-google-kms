# Monitoring Alert Example

This example provides monitoring e-mail alerts for KMS key versions scheduled for destruction. If multiple key versions are deleted in less than 5 minutes a single notification will be sent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| email\_addresses\_to\_be\_notified | Email addresses used for sending notifications to. | `list(string)` | n/a | yes |
| monitor\_all\_keys\_in\_the\_project | True for all KMS key versions under the same project to be monitored, false for only the KMS key version created in this example to be monitored. Default: false. | `bool` | `false` | no |
| project\_id | The ID of the project in which to provision resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| key | The version of the created KMS key. |
| keyring | The keyring created. |
| notification\_channel\_names | Notification channel names. |
| project\_id | GCP Project ID where key version was created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
