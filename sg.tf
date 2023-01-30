 resource "aws_security_group" "custom-http-sg" {
  name        = "allow_http_access"
  description = "allow inbound http traffic"
  vpc_id      = aws_vpc.customvpc.id

  ingress {
    description = "from my ip range"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Name" = "custom-http-sg"
  }
}
 resource "aws_security_group" "custom-https-sg" {
  name        = "custom-https-sg"
  description = "allow inbound https traffic"
  vpc_id      = aws_vpc.customvpc.id

  ingress {
    description = "from my ip range"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Name" = "custom-https-sg"
  }
}
 resource "aws_security_group" "custom-ssh-sg" {
  name        = "allow_ssh_access"
  description = "allow inbound ssh traffic"
  vpc_id      = aws_vpc.customvpc.id

  ingress {
    description = "from my ip range"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Name" = "custom-ssh-sg"
  }
}
