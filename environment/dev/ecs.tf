module "ecs_cluster" {
  source              = "../../modules/environment/ecs/cluster"
  cluster_name        = local.ecs_cluster_name
  stack               = local.stack
  subnets_ids         = [
    module.subnet_public_1.id,
    module.subnet_public_2.id
  ]
  trusted_cidr_blocks = [
    module.subnet_public_1.cidr,
    module.subnet_public_2.cidr
  ]
  tmp_bucket          = local.tmp_bucket
  depends_on          = [
    module.storage
  ]
}

module "ecs_service_roles" {
  source        = "../../modules/environment/ecs/task-roles"
  cluster_name  = local.ecs_cluster_name
  s3_bucket_arn = module.storage.logs_bucket_arn
  dynamodb_arn  = module.dynamodb_table.arn
  kinesis_streams = {
    source_arn = module.kinesis.stream_arn
    target_arn = module.kinesis.stream_arn
  }
  depends_on = [
    module.kinesis,
    module.dynamodb_table
  ]
}
