resource "aws_vpc" "default" {
    cidr_block = var.vpc_cidr_block

    tags = {
       Name = "wp-pvc-tf"
    }
}

# Internet Gateway

resource "aws_internet_gateway" "default" {
    vpc_id = aws_vpc.default.id

    tags = {
       Name = "wp-igw-tf"
    }
}

# Subnets

resource "aws_subnet" "wp-public-tf" {
    vpc_id            = aws_vpc.default.id
    cidr_block        = var.public_subnet_cidr_block
    availability_zone = "us-west-2a"

    tags = {
       Name = "wp-public-tf"
    }
}

resource "aws_subnet" "wp-private-tf" {
    vpc_id            = aws_vpc.default.id
    cidr_block        = var.private_subnet_cidr_block
    availability_zone = "us-west-2b"

    tags = {
       Name = "wp-private-tf"
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


resource "aws_db_subnet_group" "default" {
    name        = "wp-db-subnet-tf"
    description = "VPC Subnets"
    subnet_ids  = [aws_subnet.wp-public-tf.id, aws_subnet.wp-private-tf.id]
}

resource "aws_db_instance" "wordpress" {
    identifier             = "wordpress-tf"
    allocated_storage      = 5
    engine                 = "mysql"
    engine_version         = "5.7.22"
    port                   = "3306"
    instance_class         = var.db_instance_type
    name                   = var.db_name
    username               = var.db_user
    password               = var.db_password
    availability_zone      = "us-west-2b"
    vpc_security_group_ids = [aws_security_group.wp-db-sg-tf.id]
    multi_az               = false
    db_subnet_group_name   = aws_db_subnet_group.default.id
    parameter_group_name   = "default.mysql5.7"
    publicly_accessible    = false
}
