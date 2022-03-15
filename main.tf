provider "aws" {
  region     = "us-west-2"
}

variable "cidr_blocks" {
    description = "cidr block for network configuration"
    type = list(object({
        cidr_block = string,
        name = string
    }))
}

variable "env" {
    description = "Environment of vpc"
}

resource "aws_vpc" "my-app-vpc" {
  cidr_block = var.cidr_blocks[0].cidr_block
  tags = {
    Name = var.cidr_blocks[0].name,
    vpc_env = var.env
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.my-app-vpc.id
  cidr_block        = var.cidr_blocks[1].cidr_block
  availability_zone = "us-west-2b"
  tags = {
    Name = var.cidr_blocks[1].name
  }
}

data "aws_vpc" "existing_vpc" {
    id = aws_vpc.my-app-vpc.id
}
resource "aws_subnet" "dev-subnet-2" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = var.cidr_blocks[2].cidr_block
  availability_zone = "us-west-2a"
  tags = {
    Name = var.cidr_blocks[2].name
  }
}

output "dev-vpc-id" {
    value = aws_vpc.my-app-vpc.id
    description = "The id of the development vpc"
}

output "dev-subnet-1-id" {
    value = aws_subnet.dev-subnet-1.id
    description = "The id of the subnet-1 of dev vpc"
}