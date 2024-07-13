locals {
  config_json = jsondecode(file("${path.module}/cloudwatch_config/config.json"))
}
resource "aws_ssm_parameter" "cloudwatch_windows_config" {
  name  = "/${var.name}/Amazon-CloudWatch-Windows-Config"
  type  = "String"
  value = jsonencode(local.config_json)
}