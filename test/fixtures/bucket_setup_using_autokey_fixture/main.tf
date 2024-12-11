module "bucket_setup_using_autokey_fixture" {
 source              = "../../../examples/bucket_setup_using_autokey"
 kms_project_id      = var.project_id
 folder_id           = var.folder_id
 resource_project_id = var.resource_project_id
 bucket_location = var.bucket_location
}
