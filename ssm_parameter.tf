locals {
  config_json = jsondecode(file("${path.module}/cloudwatch_config/linux_config.json"))
}
resource "aws_ssm_parameter" "cloudwatch_linux_config" {
  name  = "/${var.name}/Amazon-CloudWatch-Linux-Config"
  type  = "String"
  value = jsonencode(local.config_json)
}