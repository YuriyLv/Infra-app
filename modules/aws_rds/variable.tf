variable "db_username" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
  default = "example-username"
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
  default = "example-password"
}

variable "env" {
  default = "rds"
}

variable "vpc_id" {
  default = ""
}

variable "private_subnet_ids" {
  default = ""
}

variable "public_subnet_ids" {
  default = ""
}