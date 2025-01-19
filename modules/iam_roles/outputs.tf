output "app_instance_profile_name" {
  description = "Name of the IAM Instance Profile for application instances"
  value       = aws_iam_instance_profile.app_instance_profile.name
}

output "app_instance_role_arn" {
  description = "ARN of the IAM Role for application instances"
  value       = aws_iam_role.app_instance_role.arn
}
