resource "aws_route53_record" "alb" {
  for_each = { for alias in local.aliases : alias.hostname => alias.zone_id }
  name     = each.key
  type     = "A"
  zone_id  = each.value

  alias {
    evaluate_target_health = false
    name                   = module.alb.dns_name
    zone_id                = module.alb.dns_zone_id
  }
}
