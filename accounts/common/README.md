# Prerequisites 

1. Get access token for Private Registry where `App` docker image hosted
2. Put it into AWS Secrets Manager new `docker-credentials` secret:
```json
{
  "username": "User.Name",
  "password": "eyJhbGciOiJSUzUxMiJ9.ey..."
}
```
3. Write the secret ARN to `parameter_store.tf` (`docker_credentials_secret_arn`) 