resource "aws_ssm_parameter" "docker_credentials_secret_arn" {
  name  = "/project/global/settings/docker/credentials"
  type  = "String"
  value = "arn:aws:secretsmanager:eu-west-1:285879807400:secret:docker-credentials-skP9Ri"
}

resource "aws_ssm_parameter" "kms_key_arn" {
  name  = "/project/global/settings/kms/secret_key/arn"
  type  = "String"
  value = aws_kms_key.secrets.arn
}
