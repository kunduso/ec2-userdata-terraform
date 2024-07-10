resource "aws_security_group" "endpoint-sg" {
  name        = "${var.name}-endpoint-access"
  description = "allow inbound traffic"
  vpc_id      = aws_vpc.this.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
    description = "Enable access for the endpoints."
  }
  tags = {
    "Name" = "${var.name}-endpoint-sg"
  }
}
resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.us-east-2.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private.id]
  security_group_ids  = [aws_security_group.endpoint-sg.id]
  private_dns_enabled = true
  tags = {
    "Name" = "${var.name}-ssm"
  }
}
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.us-east-2.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private.id]
  security_group_ids  = [aws_security_group.endpoint-sg.id]
  private_dns_enabled = true
  tags = {
    "Name" = "${var.name}-ec2messages"
  }
}
resource "aws_vpc_endpoint" "messsmsages" {
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.us-east-2.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private.id]
  security_group_ids  = [aws_security_group.endpoint-sg.id]
  private_dns_enabled = true
  tags = {
    "Name" = "${var.name}-ssmmessages"
  }
}