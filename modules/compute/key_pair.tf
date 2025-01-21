# Generate a private key
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create an AWS Key Pair using the public key
resource "aws_key_pair" "default" {
  key_name   = "${var.project}-key"
  public_key = tls_private_key.key.public_key_openssh
}

# Save the private key to a file locally
resource "local_file" "private_key" {
  filename = "${path.module}/${var.project}-private-key.pem"
  content  = tls_private_key.key.private_key_pem
  file_permission = "0400" 
}

output "private_key_path" {
  value = local_file.private_key.filename
  description = "Path to the private key file generated locally"
}
