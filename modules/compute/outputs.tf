output "public_target_group_arn" {
  description = "The ARN of the public target group"
  value       = aws_lb_target_group.public.arn
}

output "internal_target_group_arn" {
  description = "The ARN of the internal target group"
  value       = aws_lb_target_group.internal.arn
}

output "private_key" {
  value     = tls_private_key.key.private_key_pem
  sensitive = true
}

output "public_asg_name" {
  description = "The name of the public auto scaling group"
  value       = aws_autoscaling_group.public_asg.name
}

output "private_asg_name" {
  description = "The name of the private auto scaling group"
  value       = aws_autoscaling_group.private_asg.name
}
