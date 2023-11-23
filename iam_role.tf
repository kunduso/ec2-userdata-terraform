#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "secret_manager_policy" {
  name        = "app-1-secret-read-policy"
  path        = "/"
  description = "Policy to read secret stored in AWS Secrets Manager secret."
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          aws_secretsmanager_secret_version.secret_string.arn,
          aws_secretsmanager_secret_version.secret_json.arn
        ]
      }
    ]
  })
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "read_secret_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.secret_manager_policy.arn
}