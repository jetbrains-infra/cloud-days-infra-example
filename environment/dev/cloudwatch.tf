module "cloudwatch_app_destination" {
  source             = "../../modules/environment/cloudwatch_logs"
  kinesis_stream_arn = module.kinesis.stream_arn
  senders = [
    "466666666666",
    "888888888888"
  ]
  depends_on = [
    module.kinesis
  ]
}