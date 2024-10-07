locals {
  config_json = templatefile("${path.module}/cloudwatch_config/linux_config.json.tftpl", {
    log_group_name = aws_cloudwatch_log_group.logs.name
  })
}
resource "aws_ssm_parameter" "cloudwatch_linux_config" {
  name  = "/${var.name}/Amazon-CloudWatch-Linux-Config"
  type  = "String"
  value = local.config_json
}