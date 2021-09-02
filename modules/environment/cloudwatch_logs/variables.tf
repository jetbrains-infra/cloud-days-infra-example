variable "kinesis_stream_arn" {}
variable "senders" {
  type = list(string)
}
data "aws_region" "current" {}
data "aws_default_tags" "current" {}

locals {
  region       = data.aws_region.current.id
  stream_arn   = var.kinesis_stream_arn
  senders      = var.senders
  default_tags = { for tag in data.aws_default_tags.current.tags : tag.key => tag }
  stack        = local.default_tags.Stack.value
}
