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
