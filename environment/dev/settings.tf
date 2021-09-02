provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Project = "Project"
      Stack   = "Dev"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.5"
    }
  }
  backend "s3" {
    bucket = "project-terraform-state"
    key    = "stack-dev.state"
    region = "eu-west-1"
  }
}
