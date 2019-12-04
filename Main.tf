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

module "EC2" {
    source = "./EC2"
}

module "ELB" {
    source = "./ELB"
}

module "RDS" {
  source  = "./RDS"
}
