# Importing Autokey Key Handles Guidance

If you have any existing [Autokey Key Handles](https://cloud.google.com/kms/docs/resource-hierarchy#key_handles) previously created using [terraform-google-autokey](https://registry.terraform.io/modules/GoogleCloudPlatform/autokey/google) module, it is recommended to import them to [autokey submodule](../modules/autokey/README.md) Terraform state by following the steps below.

**Note:** You don't need to import the existing state for [Autokey configuration](https://cloud.google.com/kms/docs/enable-autokey#enable-autokey-folder) resource. The [autokey submodule](../modules/autokey/README.md) apply process will handle that automatically.

**Note 2:** These instructions were made using [terraform-google-autokey v1.1.1](https://github.com/GoogleCloudPlatform/terraform-google-autokey/releases/tag/v1.1.1) as reference. Future releases versions might require changes in this document.

**WARNING:** [terraform-google-autokey](https://registry.terraform.io/modules/GoogleCloudPlatform/autokey/google) module can be used to create your Autokey folder, Autokey KMS project, Autokey resource project and additional resources (e.g: a Cloud Storage Bucket configured with Autokey), so **DO NOT RUN** a `terraform destroy` for the existing module, even after the Key Handle import process is completed.

## Getting the existing Autokey state from terraform-google-autokey module
1. Run `cd REPLACE-WITH-YOUR-PATH` to your `terraform-google-autokey/examples/cloud_autokey_example` local module path;
   1. If you didn't use `examples/cloud_autokey_example`, make sure you update the output names in the script according your terraform files and the relative path in the command below.
1. Run the following helper script to perform `terraform output` and export the Autokey folder number, Autokey Key project, KeyHandle's names, locations and resource projects as environment variables:
    ```shell
    cp ../../../terraform-google-kms/scripts/export_autokey_env_vars.sh .
    chmod +x export_autokey_env_vars.sh
    source ./export_autokey_env_vars.sh
    ```
    **Note:** You must see values set for echos: `AUTOKEY_FOLDER_NUMBER` and `AUTOKEY_KMS_PROJECT_ID`.

    **Note 2:** You must see values just for the KeyHandles you have deployed. In other words: If you just have a KeyHandle for Bigquery, you'll just see values for: `AUTOKEY_BQ_KEY_HANDLE_PROJECT`, `AUTOKEY_BQ_KEY_HANDLE_LOCATION` and `AUTOKEY_BQ_KEY_HANDLE_NAME` echos.

## Creating the .tfvars file
1. Run `cd` to your [autokey submodule](../modules/autokey/README.md) folder;
1. Run the following helper script to automate the `terraform output` file creation:
    ```shell
    chmod +x ../../scripts/create_autokey_tfvars_file.sh
    ../../scripts/create_autokey_tfvars_file.sh
    ```

## Importing the existing Autokey state from terraform-google-autokey module using autokey submodule
1. Run `cd` to your [autokey submodule](../modules/autokey/README.md) folder;
1. Run the following helper script to automate the `terraform import` process:
    ```shell
    chmod +x ../../scripts/import_autokey_state.sh
    ../../scripts/import_autokey_state.sh
    ```
1. **Note:** For each import, you should receive the following output:
    ```
    Import successful!

    The resources that were imported are shown above. These resources are now in
    your Terraform state and will henceforth be managed by Terraform.
    ```
1. Run `terraform plan`.
1. Run `terraform apply`. **You have successfully imported the Autokey configuration and KeyHandle states**.

## Cleaning your local environment
1. Run the following helper script to unset all the environment variables used in this import process:
    ```shell
    chmod +x ../../scripts/unset_autokey_env_vars.sh
    source ../../scripts/unset_autokey_env_vars.sh
    ```
