
data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }
}
resource "aws_key_pair" "mysedkey" {
    key_name = "mysedkey"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}
resource "aws_instance" "web_server" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.custom-http-sg.id,aws_security_group.custom-https-sg.id, aws_security_group.custom-ssh-sg.id]
    subnet_id              = aws_subnet.private-1a.id
    # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#associate_public_ip_address
    associate_public_ip_address = true
    key_name = "mysedkey"
    user_data = <<-EOF
              #!/bin/bash
              sudo apt install -y yum
              sudo apt -y install nginx
              sudo systemctl start nginx.service
              echo "<html>" >> /var/www/html/index.html
              echo "<head>" >> /var/www/html/index.html
              echo "<title>Hello World</title>" >> /var/www/html/index.html
              echo "</head>" >> /var/www/html/index.html
              echo "<body>" >> /var/www/html/index.html
              echo "<h1>Hello World!</h1>" >> /var/www/html/index.html
              echo "</body>" >> /var/www/html/index.html
              echo "</html>" >> /var/www/html/index.html
              EOF  
    
    #file("user_data/user_data.tpl")
    tags = {
        Name = "web_server"
    }
}
