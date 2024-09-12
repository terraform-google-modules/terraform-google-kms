# Importing Autokey Key Handles Guidance

If you have any existing [Autokey Key Handles](https://cloud.google.com/kms/docs/resource-hierarchy#key_handles) previously created manually or using [terraform-google-autokey](https://registry.terraform.io/modules/GoogleCloudPlatform/autokey/google) module, it is possible to import them to [autokey submodule](../modules/autokey/README.md) Terraform state by following the steps below.

**Note:** You don't need to import the existing [Autokey configuration](https://cloud.google.com/kms/docs/enable-autokey#enable-autokey-folder) resource. The [autokey submodule](../modules/autokey/README.md) apply process will handle that automatically.

## Importing from terraform-google-autokey considerations
1. **WARNING:** [terraform-google-autokey](https://registry.terraform.io/modules/GoogleCloudPlatform/autokey/google) module can be used to create your Autokey folder, Autokey KMS project, Autokey resource project and additional resources (e.g: a Cloud Storage Bucket configured with Autokey), so **DO NOT RUN** a `terraform destroy` for the module, even after the Key Handle import, unless you just used the module for Autokey configuration and the Key Handle creations only.
1. If you are migrating from [terraform-google-autokey](https://registry.terraform.io/modules/GoogleCloudPlatform/autokey/google) module, you should copy the terraform outputs provided by the module and jump directly to step 4.

## Steps

1. Identify your existing Autokey folder number used to configure [Autokey configuration](https://cloud.google.com/kms/docs/enable-autokey#enable-autokey-folder).
    1. This value will be referenced as: `AUTOKEY-FOLDER-NUMBER`
1. Identify your existing project ID used to [configure Cloud KMS resources created by Autokey](https://cloud.google.com/kms/docs/enable-autokey#set-up-key-project).
    1. This value will be referenced as: `AUTOKEY-KMS-PROJECT-ID`
1. Indentify your existing [Autokey Key Handle](https://cloud.google.com/kms/docs/resource-hierarchy#key_handles) configuration. It's composed by the following:
    1. Autokey Resource Project ID; (e.g: A Cloud Storage Bucket project ID configured with Autokey);
        1. This value will be referenced as: `AUTOKEY-RESOURCE-PROJECT-ID`;
    1. Key Handle location; (e.g: A Cloud Storage Bucket location configured with Autokey);
        1. This value will be referenced as: `AUTOKEY-LOCATION`;
    1. Key Handle name; (e.g: The Key Handle name configured for Cloud Storage Bucket);
        1. This value will be referenced as: `AUTOKEY-KEYHANDLE-NAME`;
1. Run `cd` to your [autokey submodule](../modules/autokey/README.md) folder;
1. Create a `terraform.tfvars` file with the following code, replacing all the values in caps lock with your info:

    ``` terraform
    project_id            = "AUTOKEY-KMS-PROJECT-ID"
    autokey_folder_number = "AUTOKEY-FOLDER-NUMBER"
    autokey_handles = {
        YOUR_SERVICE_ALIAS = {
            name                   = "AUTOKEY-KEYHANDLE-NAME",
            project                = "AUTOKEY-RESOURCE-PROJECT-ID",
            resource_type_selector = "SERVICE.googleapis.com/TYPE",
            location               = "AUTOKEY-LOCATION"
        },
        # Note: If you have multiple Key Handles, you can append it here, following the same pattern.
        # Note 2: YOUR_SERVICE_ALIAS can be any meaningful string, e.g. "storage_bucket"
    }
    ```
1. Run `terraform init`
1. Run `terraform import google_kms_key_handle.primary["/YOUR_SERVICE_ALIAS"/] projects/AUTOKEY-RESOURCE-PROJECT-ID/locations/AUTOKEY-LOCATION/keyHandles/AUTOKEY-KEYHANDLE-NAME`. You should receive the following output:

    ```
    Import successful!

    The resources that were imported are shown above. These resources are now in
    your Terraform state and will henceforth be managed by Terraform.
    ```

    # Note: If you have multiple Key Handles, you can add it here following the same pattern.

1. Run `terraform apply`. This apply should create the existing Autokey configuration resource state.
