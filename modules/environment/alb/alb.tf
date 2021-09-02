module "alb" {
  source             = "github.com/jetbrains-infra/terraform-aws-alb?ref=v0.3.3"
  name               = local.name
  certificate_arn    = module.alb_certificate.arn
  target_cidr_blocks = ["0.0.0.0/0"] // we need allow internet access because of Cognito
  public_subnets     = local.subnet_ids
  access_log_bucket  = local.logs_storage.bucket
  access_log_prefix  = local.logs_storage.prefix
  tags               = {}
}
