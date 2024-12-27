# Upgrading to v4.0
The v4.0 release of *kms* is a backwards incompatible release.

### Autokey Submodule
The current users of Autokey submodules needs to
- Switch `project_id` to `key_project_id` (For steps check [here](#to-migrate-from-project_id-to-key_project_id))
- Stop using `autokey_handles` field to generate keyhandles, instead directly use `google_kms_key_handle` terraform resource to create keyhandles. For detailed example check [bucket_setup_using_autokey](../examples/bucket_setup_using_autokey/).


### To Migrate from `project_id` to `key_project_id`

1. Retrieve the autokey config id: Run `terraform state show module.autokey.google_kms_autokey_config.primary` and copy the resulting `id` field from the cli output to notepad
2. Delete autokey config from the state: run `terraform state rm module.autokey.google_kms_autokey_config.primary`
3. Import the autokey config id: Run `terraform  import  module.autokey.google_kms_autokey_config.primary "<paste id copied in step 1>"`