variable "build" {
  type = number
}
variable "instance_name" {
  type = string
}
variable "hostname" {
  type = string
}
variable "image" {
  type = string
}
variable "node_count" {
  default = 1
}
variable "cpu_cores" {
  default = 1
}
variable "cpu" {
  default = 1024
}
variable "mem" {
  default = 3072
}
data "aws_alb_listener" "default" {
  load_balancer_arn = local.alb_arn
  port              = "443"
}
data "aws_alb" "default" {
  arn = local.alb_arn
}
data "aws_ssm_parameter" "ecs_service_task_role_arn" {
  name = "/project/${local.stack}/settings/iam_role/app/task/arn"
}
data "aws_ssm_parameter" "ecs_cluster_arn" {
  name = "/project/${local.stack}/settings/ecs/cluster_arn"
}
data "aws_ssm_parameter" "ecs_service_role_arn" {
  name = "/project/${local.stack}/settings/ecs/service_role_arn"
}
data "aws_ssm_parameter" "ecs_task_execution_role_arn" {
  name = "/project/${local.stack}/settings/ecs/task_execution_role_arn"
}
data "aws_ssm_parameter" "ecs_capacity_provider_name" {
  name = "/project/${local.stack}/settings/ecs/capacity_provider_name"
}
data "aws_ssm_parameter" "alb_arn" {
  name = "/project/${local.stack}/settings/alb/arn"
}
data "aws_ssm_parameter" "docker_credentials" {
  name = "/project/global/settings/docker/credentials"
}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_default_tags" "current" {}

locals {
  project                     = "Project"
  service                     = "app"
  default_tags                = { for tag in data.aws_default_tags.current.tags : tag.key => tag }
  stack                       = local.default_tags.Stack.value
  build                       = var.build
  instance_name               = var.instance_name
  vpc_id                      = data.aws_alb.default.vpc_id
  hostname                    = var.hostname
  region                      = data.aws_region.current.name
  account_id                  = data.aws_caller_identity.current.id
  alb_arn                     = data.aws_ssm_parameter.alb_arn.value
  alb_listener_arn            = data.aws_alb_listener.default.arn
  ecs_cluster_arn             = data.aws_ssm_parameter.ecs_cluster_arn.value
  ecs_capacity_provider_name  = data.aws_ssm_parameter.ecs_capacity_provider_name.value
  ecs_service_role_arn        = data.aws_ssm_parameter.ecs_service_role_arn.value
  ecs_task_execution_role_arn = data.aws_ssm_parameter.ecs_task_execution_role_arn.value
  ecs_service_task_role_arn   = data.aws_ssm_parameter.ecs_service_task_role_arn.value
  app_image                   = var.image
  docker_credentials          = data.aws_ssm_parameter.docker_credentials.value
  cpu                         = var.cpu
  mem                         = var.mem
  ecs_service_task_count      = tostring(var.node_count)
  minimum_healthy_percent     = 100
  maximum_percent             = 200
  app_port                    = 8096
}
