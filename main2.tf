provider "aws" {
    region="ap-south-1"
}

resource "aws_vpc" "cust_vpc" {
    cidr_block="10.0.0.0/24"

    tags = {
        Name="testing-vpc"
        env="testing"
    }
}

resource "aws_default_subnet" "cust_sub" {
  availability_zone = "ap-south-1a"
#   cidr_block="10.0.0.0/25"
  tags = {
    Name = "Public Subnet"
  }
}


variable "vpc_id" {
  type = string
  default = "vpc-04bb7d3caa192f015" 
}
resource "aws_security_group" "allow_ssh" {
    name        = "allow-ssh"
    description = "Allow TLS inbound traffic"
    vpc_id      = var.vpc_id
 
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
