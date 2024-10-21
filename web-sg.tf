resource "aws_security_group" "web" {
  name        = "web"
  description = "web"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_allow_ssh" {
  security_group_id            = aws_security_group.web.id
  referenced_security_group_id = aws_security_group.bastion.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "web_allow_http" {
  security_group_id            = aws_security_group.web.id
  referenced_security_group_id = aws_security_group.nlb.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

resource "aws_vpc_security_group_egress_rule" "web_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
