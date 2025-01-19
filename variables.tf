variable "project" {
  description = "Project name for resource naming"
  type        = string
}

variable "db_username" {
  description = "Database master username"
  default     = "Hassan"
}

variable "db_password" {
  description = "Database master password"
  default     = "cloud#1234"
}

# variable "database_subnet_ids" {
#   description = "Subnet IDs for RDS instances"
#   type        = list(string)
# }
