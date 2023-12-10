resource "aws_security_group" "instance-sg" {
  name        = "allow_access"
  description = "allow inbound traffic"
  vpc_id      = aws_vpc.this.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enable access to the internet."
  }
  tags = {
    "Name" = "app-1-ec2-sg"
  }
}
data "aws_ami" "windows-ami" {
  filter {
    name   = "name"
    values = ["amzn2-ami-amd-hvm-2.0.20230727.0-x86_64-gp2"]
    #values = ["Windows_Server-2019-English-Full-Base-2023*"] // for linux "amzn2-ami-amd-hvm-2.0.20230727.0-x86_64-gp2"
  }
  # filter {
  #   name   = "platform"
  #   values = ["windows"]
  # }
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
  vpc_security_group_ids      = [aws_security_group.instance-sg.id]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Name = "app-1-server-1"
  }
}
locals {
  account_id = aws_vpc.this.owner_id
}