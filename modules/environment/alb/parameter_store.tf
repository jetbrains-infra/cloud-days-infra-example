resource "aws_ssm_parameter" "alb_arn" {
  name  = "/project/${local.stack}/settings/alb/arn"
  type  = "String"
  value = module.alb.arn
}
