resource "aws_ssm_parameter" "parameter_one" {
  name  = "/app-1/SecureVariableOne"
  type  = "SecureString"
  value = var.SecureVariableOne
}
