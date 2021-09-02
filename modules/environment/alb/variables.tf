variable "name" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "aliases" {
  type = list(object({
    hostname = string,
    zone_id  = string
  }))
}
variable "log_storage" {
  type = object({
    bucket = string,
    prefix = string
  })
}
data "aws_default_tags" "current" {}

locals {
  name         = var.name
  subnet_ids   = var.subnet_ids
  aliases      = var.aliases
  logs_storage = var.log_storage
  default_tags = {for tag in data.aws_default_tags.current.tags: tag.key => tag }
  stack        = local.default_tags.Stack.value
}
