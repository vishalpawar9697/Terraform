# Define the AWS provider
provider "aws" {
  region = "us-west-2" # Specify your region
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"
  tags = {
    Name = "public-subnet"
  }
}

#create privat subnet

resource "aws_subnet" "privat_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-west-2c"
    tags = {
      Name = "private-subnet"

    }
  
}

# Create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "internet-gateway"
  }
}

# Create a route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "public-route-table"
  }
}


# Add a route to the internet gateway in the route table
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# create elastic ip for nat-gateway

resource "aws_eip" "nat_eip" {
    vpc = true
    tags = {
        Name = "Nat-eip"
    }
}

# Ceate a privat route table
resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "private-route-table"
    } 
}

# create NAT getway
resource "aws_nat_gateway" "pub_nat_gateway" {
    allocation_id = "aws_eip.nat_eip.id"
    subnet_id = "aws_subnet_public_subnet.id"
    tags = {
      Name = "nat-gateway"
    }
}

# Route private subnet traffic through the NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.pub_nat_gateway.id
}

# Associate the private route table with the private subnet
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.privat_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# Create a security group
resource "aws_security_group" "default_sg" {
  name        = "default-sg"
  description = "Default security group"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "default-security-group"
  }
}
