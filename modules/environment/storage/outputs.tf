output "alb_logs_bucket" {
  value = module.data_storage.alb_logs_bucket
}
output "alb_logs_path" {
  value = module.data_storage.alb_logs_path
}
output "logs_bucket_arn" {
  value = module.data_storage.bucket_arn
}
