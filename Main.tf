# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "terraform-lab-demo"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}

# Use AWS Terraform provider
provider "aws" {
  region = "us-west-2"
}

module "VPC" {
    source = "./VPC"
}

module "EC2" {
    source = "./EC2"
    
    subnet_id   = "module.aws_subnet.wp-public-tf.id"
    vpc_id      = "module.aws_vpc.default.id"
    
}

module "ELB" {
    source = "./ELB"
}

module "RDS" {
  source  = "./RDS"
}
