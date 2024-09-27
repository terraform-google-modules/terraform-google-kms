# Importing Autokey Key Handles Guidance

If you have any existing [Autokey Key Handles](https://cloud.google.com/kms/docs/resource-hierarchy#key_handles) previously created using [terraform-google-autokey](https://registry.terraform.io/modules/GoogleCloudPlatform/autokey/google) module, it is recommended to import them to [autokey submodule](../modules/autokey/README.md) Terraform state by following the steps below.

**Note:** You don't need to import the existing state for [Autokey configuration](https://cloud.google.com/kms/docs/enable-autokey#enable-autokey-folder) resource. The [autokey submodule](../modules/autokey/README.md) apply process will handle that automatically.

**Note 2:** These instructions were made using [terraform-google-autokey v1.1.1](https://github.com/GoogleCloudPlatform/terraform-google-autokey/releases/tag/v1.1.1) as reference. Future releases versions might require changes in this document.

**WARNING:** [terraform-google-autokey](https://registry.terraform.io/modules/GoogleCloudPlatform/autokey/google) module can be used to create your Autokey folder, Autokey KMS project, Autokey resource project and additional resources (e.g: a Cloud Storage Bucket configured with Autokey), so **DO NOT RUN** a `terraform destroy` for the module, even after the Key Handle import process is completed, unless you just used the module for Autokey configuration and the Key Handle creations only.

## Getting the existing Autokey state from terraform-google-autokey module
1. Run `cd REPLACE-WITH-YOUR-PATH` to your `terraform-google-autokey/examples/cloud_autokey_example` module path;
   1. If you didn't use `examples/cloud_autokey_example`, make sure you update the output names below according your terraform files.
1. Run `terraform output` to get the name of the Autokey folder number and Autokey Key project:
    ```bash
    export AUTOKEY_FOLDER_NUMBER=$(terraform output -raw autokey_config | cut -d'/' -f2)
    export AUTOKEY_KMS_PROJECT_ID=$(echo "module.autokey.key_project_id" | terraform console)
    echo AUTOKEY_FOLDER_NUMBER: $AUTOKEY_FOLDER_NUMBER
    echo AUTOKEY_KMS_PROJECT_ID: $AUTOKEY_KMS_PROJECT_ID
    ```
    **Note:** You must see values set for both echos: `AUTOKEY_FOLDER_NUMBER` and `AUTOKEY_KMS_PROJECT_ID`.
1. Run `terraform output` to get the KeyHandle's names, locations and projects:
    ```bash
    echo Getting Bigquery Dataset KeyHandle
    export AUTOKEY_BQ_KEY_HANDLE_PROJECT=$(terraform output -raw bq_key_handle | cut -d'/' -f2)
    export AUTOKEY_BQ_KEY_HANDLE_LOCATION=$(terraform output -raw bq_key_handle | cut -d'/' -f4)
    export AUTOKEY_BQ_KEY_HANDLE_NAME=$(terraform output -raw bq_key_handle | cut -d'/' -f6)
    echo AUTOKEY_BQ_KEY_HANDLE_PROJECT: $AUTOKEY_BQ_KEY_HANDLE_PROJECT
    echo AUTOKEY_BQ_KEY_HANDLE_LOCATION: $AUTOKEY_BQ_KEY_HANDLE_LOCATION
    echo AUTOKEY_BQ_KEY_HANDLE_NAME: $AUTOKEY_BQ_KEY_HANDLE_NAME

    echo Getting Compute Disk KeyHandle
    export AUTOKEY_DISK_KEY_HANDLE_PROJECT=$(terraform output -raw disk_key_handle | cut -d'/' -f2)
    export AUTOKEY_DISK_KEY_HANDLE_LOCATION=$(terraform output -raw disk_key_handle | cut -d'/' -f4)
    export AUTOKEY_DISK_KEY_HANDLE_NAME=$(terraform output -raw disk_key_handle | cut -d'/' -f6)
    echo AUTOKEY_DISK_KEY_HANDLE_PROJECT: $AUTOKEY_DISK_KEY_HANDLE_PROJECT
    echo AUTOKEY_DISK_KEY_HANDLE_LOCATION: $AUTOKEY_DISK_KEY_HANDLE_LOCATION
    echo AUTOKEY_DISK_KEY_HANDLE_NAME: $AUTOKEY_DISK_KEY_HANDLE_NAME

    echo Getting Storage Bucket KeyHandle
    export AUTOKEY_GCS_KEY_HANDLE_PROJECT=$(terraform output -raw gcs_key_handle | cut -d'/' -f2)
    export AUTOKEY_GCS_KEY_HANDLE_LOCATION=$(terraform output -raw gcs_key_handle | cut -d'/' -f4)
    export AUTOKEY_GCS_KEY_HANDLE_NAME=$(terraform output -raw gcs_key_handle | cut -d'/' -f6)
    echo AUTOKEY_GCS_KEY_HANDLE_PROJECT: $AUTOKEY_GCS_KEY_HANDLE_PROJECT
    echo AUTOKEY_GCS_KEY_HANDLE_LOCATION: $AUTOKEY_GCS_KEY_HANDLE_LOCATION
    echo AUTOKEY_GCS_KEY_HANDLE_NAME: $AUTOKEY_GCS_KEY_HANDLE_NAME
    ```
    **Note:** You must see values just for the KeyHandles you have deployed. In other words: If you just have a KeyHandle for Bigquery, you'll just see values for: `AUTOKEY_BQ_KEY_HANDLE_PROJECT`, `AUTOKEY_BQ_KEY_HANDLE_LOCATION` and `AUTOKEY_BQ_KEY_HANDLE_NAME` echos.

## Initialize the Autokey submodule
1. Run `cd` to your [autokey submodule](../modules/autokey/README.md) folder;
1. Create a `terraform.tfvars` file template by running the following command:
    ``` shell
    echo "
    project_id            = "$AUTOKEY_KMS_PROJECT_ID"
    autokey_folder_number = "$AUTOKEY_FOLDER_NUMBER"
    " > terraform.tfvars
1. Run `terraform init`;
1. Run `terraform plan`;
1. Run `terraform apply`. This apply should create the existing Autokey configuration resource state;

## Importing the existing Autokey state from terraform-google-autokey module using autokey submodule.
1. Run `cd` to your [autokey submodule](../modules/autokey/README.md) folder;
1. Append the existing `terraform.tfvars` file by running the following command:
    ``` shell
    echo "
    autokey_handles = {
        # Delete this block if you don't have KeyHandle for Bigquery
        bq_dataset = {
            name                   = \"$AUTOKEY_BQ_KEY_HANDLE_NAME-$AUTOKEY_SUBMODULE_RANDOM\",
            project                = \"$AUTOKEY_BQ_KEY_HANDLE_PROJECT\",
            resource_type_selector = \"bigquery.googleapis.com/Dataset\",
            location               = \"$AUTOKEY_BQ_KEY_HANDLE_LOCATION\"
        },
        # Delete this block if you don't have KeyHandle for Compute
        compute_disk = {
            name                   = \"$AUTOKEY_DISK_KEY_HANDLE_NAME-$AUTOKEY_SUBMODULE_RANDOM\",
            project                = \"$AUTOKEY_DISK_KEY_HANDLE_PROJECT\",
            resource_type_selector = \"compute.googleapis.com/Disk\",
            location               = \"$AUTOKEY_DISK_KEY_HANDLE_LOCATION\"
        },
        # Delete this block if you don't have KeyHandle for Storage
        gcs_bucket = {
            name                   = \"$AUTOKEY_GCS_KEY_HANDLE_NAME-$AUTOKEY_SUBMODULE_RANDOM\",
            project                = \"$AUTOKEY_GCS_KEY_HANDLE_PROJECT\",
            resource_type_selector = \"storage.googleapis.com/Bucket\",
            location               = \"$AUTOKEY_GCS_KEY_HANDLE_LOCATION\"
        },
    }
    " >> terraform.tfvars
    ```
1. Run one `terraform import` command for each KeyHandle you have declared in your `.tfvars` file.
    1. For Bigquey:
        ``` shell
        terraform import google_kms_key_handle.primary[\"bq_dataset\"] projects/$AUTOKEY_BQ_KEY_HANDLE_PROJECT/locations/$AUTOKEY_BQ_KEY_HANDLE_LOCATION/keyHandles/$AUTOKEY_BQ_KEY_HANDLE_NAME
        ```
    1. For Compute:
        ``` shell
        terraform import google_kms_key_handle.primary[\"compute_disk\"] projects/$AUTOKEY_DISK_KEY_HANDLE_PROJECT/locations/$AUTOKEY_DISK_KEY_HANDLE_LOCATION/keyHandles/$AUTOKEY_DISK_KEY_HANDLE_NAME
        ```
    1. For Storage:
        ``` shell
        terraform import google_kms_key_handle.primary[\"gcs_bucket\"] projects/$AUTOKEY_GCS_KEY_HANDLE_PROJECT/locations/$AUTOKEY_GCS_KEY_HANDLE_LOCATION/keyHandles/$AUTOKEY_GCS_KEY_HANDLE_NAME
        ```
    1. **Note:** For each import, you should receive the following output:

        ```
        Import successful!

        The resources that were imported are shown above. These resources are now in
        your Terraform state and will henceforth be managed by Terraform.
        ```
1. Run `terraform plan`.
1. Run `terraform apply`. **You successfully imported the Autokey state**.
