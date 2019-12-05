# EC2 Instances

resource "aws_instance" "ec2-instance" {
    ami                         = var.ami
    instance_type               = var.instance_type
    availability_zone           = "us-west-2a"
    subnet_id                   = aws_subnet.wp-public-tf.id
    key_name                    = var.key_name
    associate_public_ip_address = true
    security_groups             = [aws_security_group.wp-sg-tf.id]
    user_data                   = file("EC2/installing-components.sh")
    tags = {
      Name = "ec2-instance"
    }
}


# SG

resource "aws_security_group" "wp-sg-tf" {
  name        = "wp-instance-tf"
  description = "Security group for EC2 Instances"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wp-sg-tf"
  }
}

resource "aws_security_group" "wp-db-sg-tf" {
  name        = "wp-db-tf"
  description = "Access to the RDS instances from the VPC"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wp-db-sg-tf"
  }
}

resource "aws_security_group" "wp-elb-tf" {
  name        = "wp-sg-elb-tf"
  description = "Security Group for the ELB"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wp-sg-elb-tf"
  }
}
