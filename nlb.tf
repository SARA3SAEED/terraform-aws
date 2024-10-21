resource "aws_lb" "http" {
  name               = "web"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.public-b.id]

  security_groups = [aws_security_group.nlb.id]

  enable_deletion_protection = false
}

output "nlb_url" {
  value = aws_lb.http.dns_name
}

resource "aws_lb_target_group" "web" {
  name     = "web"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id
  health_check {
    interval = 5
    timeout  = 2
    protocol = "TCP"
  }
}

resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = aws_instance.web.id
  port             = 80
}


resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.http.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
