data "aws_default_tags" "current" {}

locals {
  default_tags = {for tag in data.aws_default_tags.current.tags: tag.key => tag }
  stack        = local.default_tags.Stack.value
}
