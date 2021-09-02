module "alb" {
  source     = "../../modules/environment/alb"
  name       = local.name
  aliases    = local.aliases
  subnet_ids = [
    module.subnet_public_1.id,
    module.subnet_public_2.id
  ]
  log_storage = {
    bucket = module.storage.alb_logs_bucket,
    prefix = module.storage.alb_logs_path
  }
}
