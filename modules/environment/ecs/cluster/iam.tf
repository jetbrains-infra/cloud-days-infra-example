data "aws_iam_policy_document" "read_params_for_ecs_task" {
  statement {
    sid       = "AllowReadParamsFromParameterStore"
    actions   = ["ssm:GetParameter*"]
    resources = ["arn:aws:ssm:${local.region}:${local.account_id}:parameter/*"]
  }
  statement {
    sid     = "AllowReadEncryptedSecrets"
    actions = ["kms:Decrypt", "secretsmanager:GetSecretValue"]
    resources = [
      local.docker_credentials,
      local.kms_key
    ]
  }
}

resource "aws_iam_role_policy" "read_params_for_ecs_task" {
  name       = "AllowReadParamsAndSecrets${title(local.stack)}"
  policy     = data.aws_iam_policy_document.read_params_for_ecs_task.json
  role       = module.ecs_cluster.ecs_default_task_role_name
  depends_on = [module.ecs_cluster.security_group_id]
}

data "aws_iam_policy_document" "allow_interact_with_tmp_bucket" {
  statement {
    actions = ["s3:*"]
    resources = [
      "${local.tmp_bucket_arn}/*",
      local.tmp_bucket_arn
    ]
  }
}

resource "aws_iam_policy" "allow_manage_tmp_bucket" {
  name   = "AllowInteractWithTmpBucket${title(local.stack)}"
  policy = data.aws_iam_policy_document.allow_interact_with_tmp_bucket.json
}

resource "aws_iam_role_policy_attachment" "allow_ecs_instances_to_manage_tmp_bucket" {
  policy_arn = aws_iam_policy.allow_manage_tmp_bucket.arn
  role       = module.ecs_cluster.iam_instance_role_name
  depends_on = [module.ecs_cluster.security_group_id]
}
