resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "${var.name}"
  }
  enable_dns_hostnames = true
  enable_dns_support   = true
}
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_cidr_private
  availability_zone = "us-east-2a"
  tags = {
    "Name" = "${var.name}-private"
  }
}
resource "aws_route_table" "this-rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${var.name}-route-table"
  }
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.this-rt.id
}