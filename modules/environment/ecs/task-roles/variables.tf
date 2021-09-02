variable "cluster_name" {
  type = string
}
variable "kinesis_streams" {
  type = object({
    source_arn = string,
    target_arn = string
  })
}
variable "s3_bucket_arn" {
  type = string
}
variable "dynamodb_arn" {
  type = string
}
data "aws_default_tags" "current" {}

locals {
  name            = var.cluster_name
  default_tags    = { for tag in data.aws_default_tags.current.tags : tag.key => tag }
  stack           = local.default_tags.Stack.value
  kinesis_stream  = var.kinesis_streams
  logs_bucket_arn = var.s3_bucket_arn
  dynamodb_arn    = var.dynamodb_arn
}
