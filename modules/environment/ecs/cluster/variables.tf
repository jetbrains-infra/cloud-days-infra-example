variable "cluster_name" {
  type = string
}
variable "trusted_cidr_blocks" {
  type = list(string)
}
variable "subnets_ids" {
  type = list(string)
}
variable "tmp_bucket" {
  type = string
}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_s3_bucket" "tmp" {
  bucket = local.tmp_bucket
}
data "aws_ssm_parameter" "kms_key" {
  name = "/project/global/settings/kms/secret_key/arn"
}
data "aws_ssm_parameter" "docker_credentials" {
  name = "/project/global/settings/docker/credentials"
}
data "aws_default_tags" "current" {}

locals {
  default_tags        = { for tag in data.aws_default_tags.current.tags : tag.key => tag }
  stack               = local.default_tags.Stack.value
  trusted_cidr_blocks = var.trusted_cidr_blocks
  subnets_ids         = var.subnets_ids
  cluster_name        = var.cluster_name
  tmp_bucket          = var.tmp_bucket
  tmp_bucket_arn      = data.aws_s3_bucket.tmp.arn
  region              = data.aws_region.current.name
  account_id          = data.aws_caller_identity.current.id
  kms_key             = data.aws_ssm_parameter.kms_key.value
  docker_credentials  = data.aws_ssm_parameter.docker_credentials.value
}