module "cloudwatch_project_destination" {
  source             = "../../modules/environment/cloudwatch_logs"
  kinesis_stream_arn = module.kinesis.stream_arn
  senders = [
    "401111111111",
    "055555555555"
  ]
  depends_on = [
    module.kinesis
  ]
}
