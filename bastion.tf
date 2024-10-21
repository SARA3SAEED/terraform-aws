resource "aws_instance" "bastion" {
  ami           = var.ubuntu_ami_id
  instance_type = "t3.micro"

  key_name = aws_key_pair.http.key_name

  vpc_security_group_ids = [aws_security_group.bastion.id]

  subnet_id = aws_subnet.public-b.id

  associate_public_ip_address = true

  tags = {
    Name = "bastion"
  }
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}
