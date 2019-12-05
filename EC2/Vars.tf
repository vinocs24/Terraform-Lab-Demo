variable "region" {
  description = "AWS Region"
  default     = "us-west-2"
}

variable "key_name" {
  description = "SSH key name to access the EC2 instances"
  default     = "rds-key"
}

variable "availability_zones" {
  description = "Availability Zones"
  default     = "us-west-2a,us-west-2b,us-west-2c"
}

variable "ami" {
  description = "EC2 Instances AMIs"
  default = "ami-08d489468314a58df"
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.micro"
}
