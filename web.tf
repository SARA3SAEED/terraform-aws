resource "aws_instance" "web" {
  ami           = var.ubuntu_ami_id
  instance_type = "t3.micro"

  key_name = aws_key_pair.http.key_name

  vpc_security_group_ids = [aws_security_group.web.id]

  subnet_id = aws_subnet.private-b.id

  associate_public_ip_address = false

  tags = {
    Name = "web"
  }
}

output "web_private_ip" {
  value = aws_instance.web.private_ip
}
