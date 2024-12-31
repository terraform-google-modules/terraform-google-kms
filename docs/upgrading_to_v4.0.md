# Upgrading to v4.0
The v4.0 release of *kms* is a backwards incompatible release.

### Autokey Submodule
The current users of Autokey submodules needs to
- Switch `project_id` to `key_project_id`
- Stop using `autokey_handles` field to generate keyhandles, instead directly use `google_kms_key_handle` terraform resource to create keyhandles. For detailed example check [bucket_setup_using_autokey](../examples/bucket_setup_using_autokey/).


### To Migrate from v3.0 to v4.0
Using V3.0 of Autokey modules if you have created keyhandles and wants to use them with V4.0 version then they need to be imported using below steps

1. Retrieve the keyhandles created:
    -  Run `terraform  state list module.autokey.google_kms_key_handle.primary` to list all keyhandles created using v3.0
    -  For each item in the output of above CLI, run `terraform state show 'module.autokey.google_kms_key_handle.primary["<an id from the output of list>"]'` and copy the resulting `id` field from the cli output to notepad
2. Delete all keyhandles from the state: run `terraform state rm module.autokey.google_kms_key_handle.primary`
3. Update the main root module to use V4.0 version. Add the keyhandle config definition to the main root module for all the keyhandle found in step1.
4. Import all the keyhandles configs using id copied in setp1 to the terraform state
    - for each keyhandle id found in step1, Run `terraform  import resource.google_kms_key_handle.<key_handle_name_given_in_step3> "<paste corresponding keyhandle id copied in step 1>"`


