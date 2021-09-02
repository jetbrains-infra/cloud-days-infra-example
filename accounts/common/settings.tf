provider "aws" {
  region = "eu-west-1"

  // https://learn.hashicorp.com/tutorials/terraform/aws-default-tags
  default_tags {
    tags = {
      Project = "MyProject"
      Stack   = "Dev"
    }
  }
}

terraform {
  backend "s3" {
    region = "eu-west-1"
    key    = "account.tf"
    bucket = "project-dev-terraform-state"
  }
}
