data "aws_iam_policy_document" "allow_store_objects_to_s3" {
  statement {
    sid       = "ManageBucketACL"
    actions   = [
      "s3:PutBucketAcl",
      "s3:GetBucketAcl"
    ]
    resources = [
      module.data_storage.bucket_arn
    ]
  }
}

resource "aws_iam_role_policy" "allow_store_objects" {
  name   = "AllowStoreObjectsToS3${title(local.stack)}"
  policy = data.aws_iam_policy_document.allow_store_objects_to_s3.json
  role   = local.project_task_role_id
}
