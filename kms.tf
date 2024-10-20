#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key
resource "aws_kms_key" "custom_kms_key" {
  description             = "KMS key for ${var.name}"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias
resource "aws_kms_alias" "key" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.custom_kms_key.id
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy
resource "aws_kms_key_policy" "encrypt_app" {
  key_id = aws_kms_key.custom_kms_key.id
  policy = jsonencode({
    Id = "ssm-encryption"
    Statement = [
      {
        Action = [
          "kms:*"
        ]
        Effect = "Allow"
        Principal = {
          AWS = "${local.principal_root_arn}"
        }
        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
      {
        Effect = "Allow",
        Principal = {
          Service = "ssm.amazonaws.com"
        },
        Action = [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*"
        ],
        Resource = "*",
        Condition = {
          StringEquals = {
            "kms:ViaService" = "ssm.${var.region}.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
  })
}