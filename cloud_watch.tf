#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "logs" {
  name              = "/${var.name}/ec2/linux"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.custom_kms_key.arn
}