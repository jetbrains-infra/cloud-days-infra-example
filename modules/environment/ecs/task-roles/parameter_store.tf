resource "aws_ssm_parameter" "project_task_role_arn" {
  name  = "/project/${local.stack}/settings/iam_role/app/task/arn"
  type  = "String"
  value = aws_iam_role.project_ecs_task_role.arn
}

resource "aws_ssm_parameter" "project_task_role_id" {
  name  = "/project/${local.stack}/settings/iam_role/app/task/id"
  type  = "String"
  value = aws_iam_role.project_ecs_task_role.id
}
