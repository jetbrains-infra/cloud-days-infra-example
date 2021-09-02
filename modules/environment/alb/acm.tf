module "alb_certificate" {
  name    = local.name
  source  = "github.com/jetbrains-infra/terraform-aws-acm-certificate?ref=v0.3.0"
  aliases = local.aliases
}
