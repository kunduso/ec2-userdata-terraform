data "aws_ami" "linux_ami" {
  filter {
    name   = "name"
    values = ["amzn2-ami-amd-hvm-2.0.20230727.0-x86_64-gp2"]
    #values = ["Windows_Server-2019-English-Full-Base-2023*"] // for linux "amzn2-ami-amd-hvm-2.0.20230727.0-x86_64-gp2"
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
  ami                         = data.aws_ami.linux_ami.id
  vpc_security_group_ids      = [aws_security_group.instance-sg.id]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  user_data = templatefile("user_data/user_data.tpl",
    {
      Parameter_Name = aws_ssm_parameter.cloudwatch_linux_config.name
  })
  tags = {
    Name = "${var.name}-server-1"
  }
}