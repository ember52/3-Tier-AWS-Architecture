resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "default" {
  key_name   = "${var.project}-key"
  public_key = tls_private_key.key.public_key_openssh
}


