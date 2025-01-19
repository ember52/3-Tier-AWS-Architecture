variable "project" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "public_security_group" {
  description = "Public security group ID"
  type        = string
}

variable "private_security_group" {
  description = "Private security group ID"
  type        = string
}

variable "public_alb_security_group" {
  description = "Security group for the public ALB"
  type        = string
}

variable "internal_alb_security_group" {
  description = "Security group for the internal ALB"
  type        = string
}
