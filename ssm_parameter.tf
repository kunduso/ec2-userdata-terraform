#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter
resource "aws_ssm_parameter" "ec2_password" {
  name   = "/${var.name}/ec2-password"
  type   = "SecureString"
  value  = random_password.auth.result
}