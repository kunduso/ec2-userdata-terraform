#Create a role
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "ec2_role" {
  name = "${var.name}-ec2-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

#Attach role to policy
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "custom" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#Attach role to an instance profile
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.name}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_policy" "custom_policy" {
  name        = "${var.name}-custom-policy-windows-rdp"
  path        = "/"
  description = "A policy to allow RDP to Windows Amazon EC2 instances."

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
            Effect= "Allow",
            Action= [
                "ec2:DescribeInstances",
                "ec2:GetPasswordData"
            ],
            Resource= "*"
        },
        {
            Sid= "SSM",
            Effect="Allow",
            Action = [
                "ssm:DescribeInstanceProperties",
                "ssm:GetCommandInvocation",
                "ssm:GetInventorySchema"
            ],
            Resource = "*"
        },
        {
            Sid = "TerminateSession",
            Effect = "Allow",
            Action = [
                "ssm:TerminateSession"
            ],
            Resource = "*"
        },
        {
            Sid = "SSMStartSession",
            Effect = "Allow",
            Action = [
                "ssm:StartSession"
            ],
            Resource = [
                "arn:aws:ec2:*:${data.aws_caller_identity.current.account_id}:instance/*",
                "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:managed-instance/*",
                "arn:aws:ssm:*::document/AWS-StartPortForwardingSession"
            ],
            Condition = {
                "BoolIfExists": {
                    "ssm:SessionDocumentAccessCheck": "true"
                },
                "ForAnyValue:StringEquals": {
                    "aws:CalledVia": "ssm-guiconnect.amazonaws.com"
                }
            }
        },
        {
            Sid = "GuiConnect",
            Effect = "Allow",
            Action = [
                "ssm-guiconnect:CancelConnection",
                "ssm-guiconnect:GetConnection",
                "ssm-guiconnect:StartConnection"
            ],
            Resource = "*"
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "custom_rdp" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.custom_policy.arn
}