// todo: add an ec2 instance
resource "aws_vpc" "this" {
  cidr_block = "10.20.20.0/25"
  tags = {
    "Name" = "Application-1"
  }
}
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.20.20.0/26"
  availability_zone = "us-east-2a"
  tags = {
    "Name" = "Application-1-private"
  }
}
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.20.20.64/26"
  availability_zone = "us-east-2a"
  tags = {
    "Name" = "Application-1-public"
  }
}
resource "aws_route_table" "this-rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "Application-1-route-table"
  }
}
resource "aws_route_table_association" "this-rta" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.this-rt.id
}
resource "aws_internet_gateway" "this-igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "Application-1-gateway"
  }
}
resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.this-rt.id
  gateway_id             = aws_internet_gateway.this-igw.id
}
resource "aws_network_interface" "this-nic" {
  subnet_id = aws_subnet.public.id
  security_groups = [aws_security_group.web-pub-sg.id]
  tags = {
    "Name" = "Application-1-nic"
  }
}
resource "aws_eip" "this-eip" {
  vpc = true
  network_interface = aws_network_interface.this-nic.id
  associate_with_private_ip = "10.20.20.76"
    tags = {
    "Name" = "Application-1-eip"
  }
}