variable "build" {}

locals {
  build         = var.build
  stack         = "dev"
  instance_name = terraform.workspace
  hostname      = "${local.instance_name}-app.${local.stack}.project.example.com"
}
