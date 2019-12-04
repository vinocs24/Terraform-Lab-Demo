# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "terraform-lab-demo"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}

# VPC

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

# Route Tables

resource "aws_route_table" "wp-rt-public-tf" {
    vpc_id = aws_vpc.default.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.default.id
    }

    tags = {
       Name = "wp-rt-public-tf"
    }
}


# Use AWS Terraform provider
provider "aws" {
  region = "us-west-2"
}

module "EC2" {
    source = "./EC2"
}

module "ELB" {
    source = "./ELB"
}

module "RDS" {
  source  = "./RDS"
}
