resource "aws_ssm_parameter" "logs_bucket" {
  name  = "/project/${local.stack}/settings/s3/logs_bucket"
  type  = "String"
  value = local.logs_bucket
}
