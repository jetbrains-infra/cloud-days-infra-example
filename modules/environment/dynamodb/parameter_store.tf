resource "aws_ssm_parameter" "dynamodb_table" {
  name  = "/project/${local.stack}/settings/dynamodb/table"
  type  = "String"
  value = aws_dynamodb_table.app.name
}
