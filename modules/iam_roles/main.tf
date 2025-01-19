# IAM Role for Application Instances
resource "aws_iam_role" "app_instance_role" {
  name = "${var.project}-app-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy for Application Instances
resource "aws_iam_policy" "app_policy" {
  name        = "${var.project}-app-policy"
  description = "IAM policy for application instances"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBSnapshots",
          "rds:ListTagsForResource",
          "rds:DescribeDBClusterEndpoints",
          "s3:GetObject",
          "s3:PutObject",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the Policy to the Role
resource "aws_iam_role_policy_attachment" "app_policy_attachment" {
  role       = aws_iam_role.app_instance_role.name
  policy_arn = aws_iam_policy.app_policy.arn
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "app_instance_profile" {
  name = "${var.project}-app-instance-profile"
  role = aws_iam_role.app_instance_role.name
}
