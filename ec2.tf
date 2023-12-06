resource "aws_security_group" "web-pub-sg" {
  name        = "allow_inbound_access"
  description = "allow inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "from library ip range"
    from_port   = "3389"
    to_port     = "3389"
    protocol    = "tcp"
    cidr_blocks = ["147.219.191.0/24"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Name" = "app-1-ec2-sg"
  }
}
data "aws_ami" "windows-ami" {
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-2023*"]
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

resource "aws_instance" "app-server" {
  instance_type               = "t2.micro"
  ami                         = data.aws_ami.windows-ami.id
  vpc_security_group_ids      = [aws_security_group.web-pub-sg.id]
  subnet_id                   = aws_subnet.public.id
  key_name                    = "skundu-sandbox"
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  user_data = templatefile("user_data/user_data.tpl",
    {
      ServerName     = var.ServerName
      SecureVariable = aws_ssm_parameter.parameter_one.name
  })
  tags = {
    Name = "app-1-server-1"
  }
}
locals {
  account_id = aws_vpc.this.owner_id
}