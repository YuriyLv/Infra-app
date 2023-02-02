output "instance_ips" {
  description = "Public IP address of the bastion instance"
  value       = aws_instance.bastion[*].public_ip
}