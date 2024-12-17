# Upgrading to v4.0
The v4.0 release of *kms* is a backwards incompatible release.

### Autokey Submodule
The current users of Autokey submodules needs to
- Switch `project_id` to `autokey_kms_project_id`
- Stop using `autokey_handles` field to generate keyhandles, instead directly use `google_kms_key_handle` terraform resource to create keyhandles. For detailed example check [bucket_setup_using_autokey](../examples/bucket_setup_using_autokey/).