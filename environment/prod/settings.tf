provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Project = "Project"
      Stack   = "Production"
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
    key    = "stack-production.state"
    region = "eu-west-1"
  }
}
