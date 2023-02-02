provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

module "vpc_homework" {
  source               = "../modules/aws_network"
  env                  = "homework"
  vpc_cidr             = "192.168.0.0/25"
  public_subnet_cidrs  = ["192.168.0.16/28", "192.168.0.32/28", "192.168.0.48/28"]
  private_subnet_cidrs = ["192.168.0.64/28", "192.168.0.80/28", "192.168.0.96/28"]
}

module "aws_bastion" {
  source             = "../modules/aws_bastion"
  env                = "bastion"
  vpc_id             = module.vpc_homework.vpc_id
  public_subnets_ids = module.vpc_homework.public_subnet_ids
}

module "aws_cicd" {
  source             = "../modules/aws_cicd"
  env                = "cicd"
  vpc_id             = module.vpc_homework.vpc_id
  private_subnet_ids = module.vpc_homework.private_subnet_ids
}

module "aws_rds" {
  source             = "../modules/aws_rds"
  env                = "rds"
  vpc_id             = module.vpc_homework.vpc_id
  private_subnet_ids = module.vpc_homework.private_subnet_ids
  public_subnet_ids = module.vpc_homework.public_subnet_ids

}

resource "local_file" "file_outputs" {
    count = length(module.aws_bastion.instance_ips)
    content = <<-EOT
    bastion ip   = ${module.aws_bastion.instance_ips[count.index]}
    cicd ip      = ${module.aws_cicd.instance_ips[count.index]}
    rds endpoint = ${module.aws_rds.rds_endpoints[count.index]}
    db_names     = ${module.aws_rds.db_names[count.index]}
    db_usernames = ${module.aws_rds.db_usernames[count.index]}
    db_passwords = ${module.aws_rds.db_passwords[count.index]}
  EOT
    filename = "endpoints.txt"
}