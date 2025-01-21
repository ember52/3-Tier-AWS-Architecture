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
