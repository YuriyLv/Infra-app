output "bastion_ips" {
  value = module.aws_bastion.instance_ips
}
output "cicd_ips" {
  value = module.aws_cicd.instance_ips
}
output "rds_endpoints" {
  value = module.aws_rds.rds_endpoints
}
output "db_names" {
  value = module.aws_rds.db_names
  sensitive = true
}
output "db_usernames" {
  value = module.aws_rds.db_usernames
  sensitive = true
}
output "db_passwords" {
  value = module.aws_rds.db_passwords
  sensitive = true
}