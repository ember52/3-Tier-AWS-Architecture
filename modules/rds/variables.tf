variable "project" {
  description = "Project name for resource naming"
  type        = string
}

variable "database_subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "db_security_group_id" {
  description = "Security group ID for RDS instances"
  type        = string
}
