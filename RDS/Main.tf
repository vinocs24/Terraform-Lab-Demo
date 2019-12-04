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

resource "aws_db_subnet_group" "default" {
    name        = "wp-db-subnet-tf"
    description = "VPC Subnets"   
    subnet_ids  = [aws_subnet.wp-public-tf.id, aws_subnet.wp-private-tf.id]
    
}

resource "aws_db_instance" "wordpress" {
    identifier             = "wordpress-db-tf"
    allocated_storage      = 5
    engine                 = "mysql"
    engine_version         = "5.7.22"
    port                   = "3306"
    instance_class         = var.db_instance_type
    name                   = var.db_name
    username               = var.db_user
    password               = var.db_password
    availability_zone      = "us-west-2b"
    vpc_security_group_ids = ["EC2/aws_security_group.wp-db-sg-tf.id"]
    multi_az               = false
    db_subnet_group_name   = aws_db_subnet_group.default.id
    parameter_group_name   = "default.mysql5.7"
    publicly_accessible    = false
}
