# Public Target Group
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

# Internal Target Group
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
