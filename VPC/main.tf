provider "aws" {
    region = "us-east-1"
  
}

resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my-vpc"
    }

}

resource "aws_subnet" "public_subnet" {
    vpc_id = "aws_vpc.my_vpc.id"
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "public-subnet"
    }  
}

resource "aws_subnet" "privat_subnet" {
    vpc_id = "aws_vpc.my_vpc.id"
    cidr_block = "10.0.2.0/24"
    tags = {
        Name = "privat-subnet"
    }  
}

resource "aws_internet_gateway" "my_igw" {
    vpc_id = "aws_vpc.my_vpc.id"
    tags = {
    Name = "my-internet-getway"
    }
  
}

resource "aws_route_table" "my_route_table" {
    vpc_id = "aws_vpc.my_vpc.id"
    tags = {
        Name = "my-route-table"
    }  
}
# Add a route to the internet gateway in the route table

resource "aws_route" "public_route" {
    route_table_id = "aws_route_table.my_route_table.id"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "aws_internet_getway.my_igw.id"

}

resource "aws_route_table_association" "public_route_table_association" {
    subnet_id = "aws_subnet.public_subnet.id"
    route_table_id = "aws_route_table.my_route_table.id"
  
}

resource "aws_security_group" "vpc_sg" {
    name = "vpc-sg"
    vpc_id = "aws_vpc.my_vpc.id"

    
ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-security-group"
  }
}


