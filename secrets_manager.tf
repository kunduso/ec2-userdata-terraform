resource "random_password" "random_secret_string" {
  length           = 25
  special          = true
  override_special = "!&#:$^<>-"
}
resource "aws_secretsmanager_secret" "secret_string" {
  name                    = "app-1-secret-string"
  recovery_window_in_days = 0
  #checkov:skip=CKV2_AWS_57: Disabled Secrets Manager secrets automatic rotation
}
resource "aws_secretsmanager_secret_version" "secret_string" {
  secret_id     = aws_secretsmanager_secret.secret_string.id
  secret_string = random_password.random_secret_string.result
}
resource "random_password" "random_secret_json" {
  length           = 15
  special          = true
  override_special = "!&#:$^<>-"
}
resource "aws_secretsmanager_secret" "secret_json" {
  name                    = "app-1-secret-json"
  recovery_window_in_days = 0
  #checkov:skip=CKV2_AWS_57: Disabled Secrets Manager secrets automatic rotation
}
resource "aws_secretsmanager_secret_version" "secret_json" {
  secret_id     = aws_secretsmanager_secret.secret_json.id
  secret_string = <<EOF
  {"username": "terraform","password":"${random_password.random_secret_json.result}"}
  EOF
}