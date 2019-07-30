locals {
  int_required_roles = [
    "roles/cloudkms.admin",

    # Needed to run verifications:
    "roles/owner"
  ]
}

resource "google_service_account" "int_test" {
  project      = module.kms-project.project_id
  account_id   = "kms-int-test"
  display_name = "kms-int-test"
}

resource "google_project_iam_member" "int_test" {
  count = length(local.int_required_roles)

  project = module.kms-project.project_id
  role    = "${element(local.int_required_roles, count.index)}"
  member  = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_service_account_key" "int_test" {
  service_account_id = google_service_account.int_test.id
}

# resource "google_billing_account_iam_member" "log_export" {
#   provider = "google.phoogle"

#   count = "${length(local.log_export_billing_account_roles)}"

#   billing_account_id = "${module.variables.phoogle_billing_account}"
#   role               = "${element(local.log_export_billing_account_roles, count.index)}"
#   member             = "serviceAccount:${google_service_account.log_export.email}"
# }

# # roles/logging.configWriter is needed at the organization level to be able to
# # test organization level log sinks.
# resource "google_organization_iam_member" "log_export" {
#   provider = "google.phoogle"

#   count = "${length(local.log_export_organization_roles)}"

#   org_id = "${var.phoogle_org_id}"
#   role   = "${element(local.log_export_organization_roles, count.index)}"
#   member = "serviceAccount:${google_service_account.log_export.email}"
# }

# # There is a test in the log-exports module that needs to spin up a project
# # within a folder, and then reference that project within the test. Because
# # of that test we need to assign roles/resourcemanager.projectCreator on the
# # folder we're using for log-exports
# resource "google_folder_iam_member" "log_export" {
#   provider = "google.phoogle"

#   count = "${length(local.log_export_folder_roles)}"

#   folder = "${google_folder.log_export.name}"
#   role   = "${element(local.log_export_folder_roles, count.index)}"
#   member = "serviceAccount:${google_service_account.log_export.email}"
# }

# resource "google_service_account_key" "log_export" {
#   provider = "google.phoogle"

#   service_account_id = "${google_service_account.log_export.id}"
# }

# resource "random_id" "log_export_github_webhook_token" {
#   byte_length = 20
# }

# data "template_file" "log_export_github_webhook_url" {
#   template = "https://concourse.infra.cft.tips/api/v1/teams/cft/pipelines/$${pipeline}/resources/pull-request/check/webhook?webhook_token=$${webhook_token}"

#   vars {
#     pipeline      = "terraform-google-log-export"
#     webhook_token = "${random_id.log_export_github_webhook_token.hex}"
#   }
# }
