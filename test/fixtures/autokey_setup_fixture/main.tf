module "autokey_setup_fixture" {
 source              = "../../../examples/autokey_setup"
 kms_project_id      = var.project_id
 folder_id           = var.folder_id
}
