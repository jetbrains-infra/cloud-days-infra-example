data "aws_route53_zone" "base_domain" {
  name = local.base_domain
}
data "aws_caller_identity" "current" {}
data "aws_default_tags" "current" {}

locals {
  default_tags     = { for tag in data.aws_default_tags.current.tags : tag.key => tag }
  stack            = local.default_tags.Stack.value
  name             = "Project${title(local.stack)}"
  logs_bucket      = "project-${local.stack}-logs"
  tmp_bucket       = "project-${local.stack}-tmp"
  base_domain      = "project.example.com"
  zone_id          = data.aws_route53_zone.base_domain.id
  ecs_cluster_name = local.name
  aliases = [
    {
      hostname = "*.${local.stack}.${local.base_domain}"
      zone_id  = local.zone_id
    }
  ]
}
