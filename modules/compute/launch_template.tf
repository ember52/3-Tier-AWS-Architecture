# Launch Template for Public Instances
resource "aws_launch_template" "public_lt" {
  name          = "${var.project}-public-lt"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.default.key_name

  iam_instance_profile {
    name = var.app_instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.public_security_group]
  }

  tags = {
    Name = "${var.project}-public-instance"
  }
}

# Launch Template for Private Instances
resource "aws_launch_template" "private_lt" {
  name          = "${var.project}-private-lt"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.default.key_name

  iam_instance_profile {
    name = var.app_instance_profile_name
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.private_security_group]
  }

  tags = {
    Name = "${var.project}-private-instance"
  }
}
