data "terraform_remote_state" "setup" {
  backend = "local"

  config = {
    path = "${path.module}/../../setup/terraform.tfstate"
  }
}
