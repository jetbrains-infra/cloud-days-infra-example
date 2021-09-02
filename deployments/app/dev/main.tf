module "app" {
  source        = "../../../modules/deployments/app"
  build         = local.build
  hostname      = local.hostname
  instance_name = local.instance_name
  image         = "private.registry.com/app"
}
