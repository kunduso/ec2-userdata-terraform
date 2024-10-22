locals {
  config_json = templatefile("${path.module}/cloudwatch_config/linux_config.json.tftpl", {
    log_group_name = aws_cloudwatch_log_group.logs.name
  })
}
resource "aws_ssm_parameter" "cloudwatch_linux_config" {
  name   = "/${var.name}/Amazon-CloudWatch-Linux-Config"
  type   = "SecureString"
  key_id = aws_kms_key.custom_kms_key.id
  value  = local.config_json
}