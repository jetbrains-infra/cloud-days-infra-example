resource "aws_ssm_parameter" "instance" {
  name      = "/project/${local.stack}/instances/${local.service}/${local.instance_name}"
  type      = "String"
  value     = "https://${local.hostname}"
  overwrite = true
}
