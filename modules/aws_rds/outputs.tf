output "rds_endpoints" {
  description = "Private IP address of the cicd instance"
  value       = aws_db_instance.rds[*].endpoint
}

output "db_names" {
  description = "db_username"
  value       = aws_db_instance.rds[*].db_name
  sensitive = true
}

output "db_passwords" {
  description = "db_username"
  value       = aws_db_instance.rds[*].password
  sensitive = true
}

output "db_usernames" {
  description = "db_username"
  value       = aws_db_instance.rds[*].username
  sensitive = true
}