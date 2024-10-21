resource "aws_security_group" "nlb" {
  name        = "nlb"
  description = "nlb"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "nlb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "nlb_allow_http" {
  security_group_id = aws_security_group.nlb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "nlb_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.nlb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
