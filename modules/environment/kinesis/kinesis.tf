resource "aws_kinesis_stream" "app" {
  name        = "app-receiver-${local.stack}"
  shard_count = local.shards
}
