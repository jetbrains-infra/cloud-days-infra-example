variable "ecs_task_role_id" {
  type = string
}
variable "buckets" {
  type = object({
    logs = string
    tmp  = string
  })
}
data "aws_default_tags" "current" {}

locals {
  default_tags         = { for tag in data.aws_default_tags.current.tags : tag.key => tag }
  stack                = local.default_tags.Stack.value
  logs_bucket          = var.buckets.logs
  tmp_bucket           = var.buckets.tmp
  project_task_role_id = var.ecs_task_role_id
}
