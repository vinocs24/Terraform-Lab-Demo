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
