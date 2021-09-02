resource "aws_cloudwatch_log_group" "service" {
  name              = "/jetbrains/${local.stack}/${local.service}/${local.instance_name}"
  retention_in_days = 7
}