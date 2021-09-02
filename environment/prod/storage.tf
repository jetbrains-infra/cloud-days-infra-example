module "storage" {
  source           = "../../modules/environment/storage"
  ecs_task_role_id = module.project_ecs_service_roles.project_task_role_id
  buckets = {
    logs = local.logs_bucket
    tmp  = local.tmp_bucket
  }
}
