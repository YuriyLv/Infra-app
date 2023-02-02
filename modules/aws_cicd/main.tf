# ----- ami latest Amazon Linux

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# ----- ec2 instanse

resource "aws_instance" "cicd" {
  count = length(var.private_subnet_ids)
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.cicd.id]
  subnet_id              = element(var.private_subnet_ids, count.index)
  associate_public_ip_address = false
  tags = {
    Name = "${var.env}-ec2-${count.index}"
  }
}

resource "aws_security_group" "cicd" {
  name = "Security Group"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env}-cicd"
  }
}