#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "auth" {
  length           = 32
  special          = true
  override_special = "!&#$"
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter
resource "aws_ssm_parameter" "ec2_password" {
  name   = "/${var.name}/ec2-password"
  type   = "SecureString"
  value  = random_password.auth.result
}