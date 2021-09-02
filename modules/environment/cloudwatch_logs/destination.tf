resource "aws_cloudwatch_log_destination" "kinesis" {
  name       = "Project${title(local.stack)}"
  role_arn   = aws_iam_role.cwl.arn
  target_arn = local.stream_arn
}

data "aws_iam_policy_document" "shared_destination" {
  statement {
    effect    = "Allow"
    actions   = ["logs:PutSubscriptionFilter", ]
    resources = [aws_cloudwatch_log_destination.kinesis.arn, ]

    principals {
      type        = "AWS"
      identifiers = local.senders
    }
  }
}

resource "aws_cloudwatch_log_destination_policy" "destination_policy" {
  destination_name = aws_cloudwatch_log_destination.kinesis.name
  access_policy    = data.aws_iam_policy_document.shared_destination.json
}
