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

resource "aws_instance" "bastion" {
  count = length(var.public_subnets_ids)
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.bastion.id]
  subnet_id              = element(var.public_subnets_ids, count.index)
  associate_public_ip_address = true
  tags = {
    Name = "${var.env}-ec2-${count.index}"
  }
}

resource "aws_security_group" "bastion" {
  name = "Security Group"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-web-bastion-sg"
  }
}