#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.this.id
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "instance-sg" {
  name        = "${var.name}-ec2-access"
  description = "allow traffic to the ec2 instance"
  vpc_id      = aws_vpc.this.id
  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.endpoint-sg.id]
    description     = "Enable access to the internet."
  }
  tags = {
    "Name" = "${var.name}-ec2-sg"
  }
}