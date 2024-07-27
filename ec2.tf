data "aws_ami" "windows-ami" {
  filter {
    name   = "name"
    #values = ["amzn2-ami-amd-hvm-2.0.20230727.0-x86_64-gp2"]
    values = ["Windows_Server-2019-English-Full-Base-2023*"] // for linux "amzn2-ami-amd-hvm-2.0.20230727.0-x86_64-gp2"
  }
  filter {
    name   = "platform"
    values = ["windows"]
  }
  filter {
    name   = "platform"
    values = ["windows"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["amazon"]
}

data "aws_caller_identity" "current" {}
resource "aws_instance" "app-server" {
  instance_type               = "t3.medium"
  ami                         = data.aws_ami.windows-ami.id
  vpc_security_group_ids      = [aws_security_group.instance-sg.id]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  user_data = templatefile("user_data/user_data.tpl",
    {
      Password = "${aws_ssm_parameter.ec2_password.value}"
  })
  tags = {
    Name = "${var.name}-server-1"
  }
}