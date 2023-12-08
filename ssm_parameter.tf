#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter
resource "aws_ssm_parameter" "parameter_one" {
  name  = "/dev/SecureVariableOne"
  type  = "SecureString"
  value = var.SecureVariableOne
}
