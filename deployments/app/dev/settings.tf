provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    region = "eu-west-1"
    key    = "project-dev-deployment.tf"
    bucket = "project-terraform-state"
  }
}
