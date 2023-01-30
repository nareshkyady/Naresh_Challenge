resource "aws_vpc" "customvpc" {
  cidr_block = "10.20.20.0/26"
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#enable_dns_support
  enable_dns_support = true
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#enable_dns_hostnames
  enable_dns_hostnames = true

  tags = {
    Name = "customvpc"
  }
}
resource "aws_subnet" "private-1a" {
  vpc_id            = aws_vpc.customvpc.id
  cidr_block        = "10.20.20.0/28"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "private-1a"
  }
}
resource "aws_subnet" "private-1b" {
  vpc_id            = aws_vpc.customvpc.id
  cidr_block        = "10.20.20.16/28"
  availability_zone = "us-east-1b"
  tags = {
    "Name" = "private-1b"
  }
}
resource "aws_subnet" "private-1c" {
  vpc_id            = aws_vpc.customvpc.id
  cidr_block        = "10.20.20.32/28"
  availability_zone = "us-east-1c"
  tags = {
    "Name" = "private-1c"
  }
}
resource "aws_route_table" "custom-rt" {
  vpc_id = aws_vpc.customvpc.id
  tags = {
    "Name" = "custom-rt"
  }
}
resource "aws_route_table_association" "private-1a" {
  subnet_id      = aws_subnet.private-1a.id
  route_table_id = aws_route_table.custom-rt.id
}
resource "aws_route_table_association" "private-1b" {
  subnet_id      = aws_subnet.private-1b.id
  route_table_id = aws_route_table.custom-rt.id
}
resource "aws_route_table_association" "private-1c" {
  subnet_id      = aws_subnet.private-1c.id
  route_table_id = aws_route_table.custom-rt.id
}
resource "aws_internet_gateway" "custom-igw" {
  vpc_id = aws_vpc.customvpc.id
  tags = {
    "Name" = "custom-igw"
  }
}
resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.custom-rt.id
  gateway_id             = aws_internet_gateway.custom-igw.id
}