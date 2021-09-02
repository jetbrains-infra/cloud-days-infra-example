data "aws_iam_policy_document" "cloudwatch_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["logs.${local.region}.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cloudwatch_permissions" {
  statement {
    sid       = "AllowWriteToDestination"
    actions   = ["kinesis:PutRecord"]
    resources = [local.stream_arn]
  }
}

resource "aws_iam_role" "cwl" {
  name               = "CloudWatchKinesisDelivery${local.stack}"
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_assume.json

  inline_policy {
    name   = "AllowWriteToDestination"
    policy = data.aws_iam_policy_document.cloudwatch_permissions.json
  }
}
