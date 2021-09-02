data "template_file" "my_user_data" {
  template = file("${path.module}/user_data.sh")
  vars = {
    bucket = local.tmp_bucket
  }
}

module "ecs_cluster" {
  source              = "github.com/jetbrains-infra/terraform-aws-ecs-cluster?ref=v0.5.0" // https://github.com/jetbrains-infra/terraform-aws-ecs-cluster/releases/latest
  cluster_name        = local.cluster_name
  trusted_cidr_blocks = local.trusted_cidr_blocks
  subnets_ids         = local.subnets_ids
  spot                = local.stack != "production"
  instance_types = {
    "t3a.large" = 1
  }
  protect_from_scale_in = false
  user_data             = data.template_file.my_user_data.rendered
}
