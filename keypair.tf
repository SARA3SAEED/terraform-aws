resource "aws_key_pair" "http" {
  key_name   = "http-terraform"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTYvnFb6vj/6F2AKV7m1rDe5lme5R24yFbT7TSdko91"
}
