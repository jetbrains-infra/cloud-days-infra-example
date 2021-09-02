resource "aws_ssm_parameter" "capacity_provider" {
  name  = "/project/${local.stack}/settings/ecs/capacity_provider_name"
  type  = "String"
  value = module.ecs_cluster.capacity_provider_name
}

resource "aws_ssm_parameter" "cluster_arn" {
  name  = "/project/${local.stack}/settings/ecs/cluster_arn"
  type  = "String"
  value = module.ecs_cluster.arn
}

resource "aws_ssm_parameter" "ecs_service_role_arn" {
  name  = "/project/${local.stack}/settings/ecs/service_role_arn"
  type  = "String"
  value = module.ecs_cluster.ecs_service_role_arn
}

resource "aws_ssm_parameter" "ecs_task_execution_role_arn" {
  name  = "/project/${local.stack}/settings/ecs/task_execution_role_arn"
  type  = "String"
  value = module.ecs_cluster.ecs_default_task_role_arn
}
