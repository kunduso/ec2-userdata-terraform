resource "aws_security_group" "ec2_instance" {
  name        = "app-1-ec2"
  description = "Allow inbound to and outbound access from the Amazon EC2 instance."
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
    description = "Enable access from any resource inside the VPC."
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enable access to the internet."
  }
  vpc_id = aws_vpc.this.id
}
data "aws_ami" "amazon_ami" {
  filter {
    name   = "name"
    values = var.ami_name
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["amazon"]
}

resource "aws_instance" "app-server-one" {
  instance_type               = var.instance_type
  ami                         = data.aws_ami.amazon_ami.id
  vpc_security_group_ids      = [aws_security_group.ec2_instance.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  tags = {
    Name = "app-1-server-1"
  }
  user_data = templatefile("user_data/user_data_one.tpl",
    {
      Region                 = var.region,
      secret_string = aws_secretsmanager_secret.secret_string.name
  })
}
resource "aws_instance" "app-server-two" {
  instance_type               = var.instance_type
  ami                         = data.aws_ami.amazon_ami.id
  vpc_security_group_ids      = [aws_security_group.ec2_instance.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  tags = {
    Name = "app-1-server-2"
  }
  user_data = templatefile("user_data/user_data_two.tpl",
    {
      Region                 = var.region,
      secret_json = aws_secretsmanager_secret.secret_json.name
  })
}