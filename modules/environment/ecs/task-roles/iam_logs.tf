resource "aws_iam_role" "project_ecs_task_role" {
  assume_role_policy = data.aws_iam_policy_document.ecs_task_role_policy.json
  name               = "EcsCluster${local.name}ProjectTaskRole"
}

data "aws_iam_policy_document" "project_ecs_task_permissions" {
  statement {
    sid = "AllowReadWriteToKinesis"
    actions = [
      "kinesis:GetShardIterator",
      "kinesis:GetRecords",
      "kinesis:ListShards",
      "kinesis:PutRecord"
    ]
    resources = [
      local.kinesis_stream.source_arn,
      local.kinesis_stream.target_arn
    ]
  }

  statement {
    sid = "AllowManageDatainDynamodb"
    actions = [
      "dynamodb:BatchWriteItem",
      "dynamodb:CreateTable",
      "dynamodb:DescribeTable",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
      "dynamodb:GetItem",
      "dynamodb:PutItem"
    ]
    resources = [
      local.dynamodb_arn
    ]
  }

  statement {
    sid       = "AllowPutMetrics"
    actions   = ["cloudwatch:PutMetricData"]
    resources = ["*"]
  }

  statement {
    sid       = "AllowManageDataInS3"
    actions   = ["s3:*"]
    resources = ["${local.logs_bucket_arn}/*"]
  }
}

resource "aws_iam_role_policy" "project_ecs_task_permissions" {
  name   = "ProjectPolicy${title(local.stack)}"
  policy = data.aws_iam_policy_document.project_ecs_task_permissions.json
  role   = aws_iam_role.project_ecs_task_role.id
}
