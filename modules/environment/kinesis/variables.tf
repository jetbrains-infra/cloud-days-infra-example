variable "shards" {
  type    = number
  default = 2
}
data "aws_default_tags" "current" {}

locals {
  shards       = var.shards
  default_tags = { for tag in data.aws_default_tags.current.tags : tag.key => tag }
  stack        = local.default_tags.Stack.value
}