output "instance_ips" {
  description = "Private IP address of the cicd instance"
  value       = aws_instance.cicd[*].private_ip
}