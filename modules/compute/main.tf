variable "app_instance_profile_name" {
  description = "The IAM instance profile name for EC2 instances"
  type        = string
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# Public Load Balancer (ALB)
resource "aws_lb" "public_alb" {
  name               = "${var.project}-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_alb_security_group]
  subnets            = var.public_subnets
  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true

  tags = {
    Name = "${var.project}-public-alb"
  }
}

# Internal Load Balancer (ALB)
resource "aws_lb" "internal_alb" {
  name               = "${var.project}-internal-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.internal_alb_security_group]
  subnets            = var.private_subnets
  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true

  tags = {
    Name = "${var.project}-internal-alb"
  }
}

# Public Target Group for ALB
resource "aws_lb_target_group" "public" {
  name     = "${var.project}-public-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.project}-public-tg"
  }
}

# Internal Target Group for ALB
resource "aws_lb_target_group" "internal" {
  name     = "${var.project}-internal-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.project}-internal-tg"
  }
}

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

# Public Auto Scaling Group
resource "aws_autoscaling_group" "public_asg" {
  desired_capacity     = 3
  max_size             = 6
  min_size             = 1
  vpc_zone_identifier  = var.public_subnets
  launch_template      {
    id      = aws_launch_template.public_lt.id
    version = "$Latest"
  }
  target_group_arns    = [aws_lb_target_group.public.arn]

  health_check_type    = "EC2"
  health_check_grace_period = 300
  force_delete         = true
}

# Private Auto Scaling Group
resource "aws_autoscaling_group" "private_asg" {
  desired_capacity     = 3
  max_size             = 6
  min_size             = 1
  vpc_zone_identifier  = var.private_subnets
  launch_template      {
    id      = aws_launch_template.private_lt.id
    version = "$Latest"
  }
  target_group_arns    = [aws_lb_target_group.internal.arn]

  health_check_type    = "EC2"
  health_check_grace_period = 300
  force_delete         = true
}
