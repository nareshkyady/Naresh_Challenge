# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "front" {
  name     = "application-front"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.customvpc.id
  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 10
    matcher = 200
    path = "/"
    port = "80"
    protocol = "HTTP"
    timeout = 3
    unhealthy_threshold = 2
  }

}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
resource "aws_lb_target_group_attachment" "attach-app1" {
  target_group_arn = aws_lb_target_group.front.arn
  target_id        = aws_instance.web_server.id
  port             = 80
}


  


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
resource "aws_lb_listener" "front_end" {
    load_balancer_arn = aws_lb.front.arn
    port              = "443"
    protocol          = "HTTPS"
    ssl_policy		=	"ELBSecurityPolicy-2016-08"
    #certificate_arn = aws_acm_certificate.my-certificate.arn
	certificate_arn		=	"${aws_iam_server_certificate.iam_cert.arn}"
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.front.arn
    }
}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "front" {
  name               = "front"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.custom-http-sg.id, aws_security_group.custom-https-sg.id]
  subnets            = [aws_subnet.private-1a.id, aws_subnet.private-1b.id, aws_subnet.private-1c.id]

  enable_deletion_protection = false

  tags = {
    Environment = "front"
  }
}

#resource "aws_lb_listener_certificate" "example" {
  #listener_arn    = aws_lb_listener.front_end.arn
  #certificate_arn = aws_acm_certificate.my-certificate.arn
#}