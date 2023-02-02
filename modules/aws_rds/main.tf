resource "aws_db_instance" "rds" {
  count = length(var.private_subnet_ids)
  identifier              = "rdsdb"
  engine                  = "postgres"
  engine_version          = "13.0"
  instance_class          = "db.t2.micro"
  db_name                 = "rdsdb"
  username                = var.db_username
  password                = var.db_password
  vpc_security_group_ids  = [aws_security_group.rds.id]
  db_subnet_group_name    = element(aws_db_subnet_group.rds[*].id, count.index)
  tags = {
    Name = "${var.env}-${count.index}"
  }
}

resource "aws_security_group" "rds" {
  name        = "rds"
  description = "Allow access to the RDS instance"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = var.vpc_id
}

resource "aws_db_subnet_group" "rds" {
  count = length(var.private_subnet_ids)
  name        = "rds-subnet-group-${count.index}"
  subnet_ids  = [element(var.private_subnet_ids, count.index), element(var.public_subnet_ids, count.index)]
  description = "RDS subnet group"
}

