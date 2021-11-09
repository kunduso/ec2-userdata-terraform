resource "aws_ssm_parameter" "parameter_one" {
  name  = "/dev/SecureVariableOne"
  type  = "SecureString"
  value = var.SecureVariableOne
}
