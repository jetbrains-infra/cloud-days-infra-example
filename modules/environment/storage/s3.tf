module "data_storage" {
  source        = "github.com/jetbrains-infra/terraform-aws-s3-bucket-for-logs?ref=v0.4.2" // https://github.com/jetbrains-infra/terraform-aws-s3-bucket-for-logs/releases/latest
  bucket        = local.logs_bucket
  force_destroy = true
  readers       = [
    "888888888888"
  ]
}

resource "aws_s3_bucket" "tmp" {
  bucket        = local.tmp_bucket
  force_destroy = true

  lifecycle_rule {
    id      = "dumps"
    enabled = true
    prefix  = "dumps/"

    tags = {
      "rule"      = "dumps"
      "autoclean" = "true"
    }

    expiration {
      days = 30
    }
  }
}
