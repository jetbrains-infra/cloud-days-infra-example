resource "aws_ssm_parameter" "kinesis_source_stream" {
  name  = "/project/${local.stack}/settings/kinesis/source/stream_name"
  type  = "String"
  value = aws_kinesis_stream.app.name
}

resource "aws_ssm_parameter" "kinesis_target_stream" {
  name  = "/project/${local.stack}/settings/kinesis/target/stream_name"
  type  = "String"
  value = aws_kinesis_stream.app.name
}
