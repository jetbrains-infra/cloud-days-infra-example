resource "aws_dynamodb_table" "app" {
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "appId"
  range_key    = "dimensionWithOrdinal"
  name         = "app-${local.stack}"

  attribute {
    name = "appId"
    type = "S"
  }

  attribute {
    name = "dimensionWithOrdinal"
    type = "S"
  }

  attribute {
    name = "ordinal"
    type = "S"
  }

  local_secondary_index {
    name            = "ordinal"
    range_key       = "ordinal"
    projection_type = "ALL"
  }
}
