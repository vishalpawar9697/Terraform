#block_type resource_type resource_name {
#configration files
#}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "myserver" {
    ami = "ami-01816d07b1128cd2d"
    key_name = "shell-keynew" 
    instance_type = "t2.micro"
    vpc_security_group_ids = [ "aws_security_group.my_sg.id" ]
    availability_zone = "us-east-1"
    tags = {
      name = "vishal"
      env = "dev"
    }
  
}

resource "aws_security_group" "my_sg" {
  name        = "my_sg"
  description = "Allow HTTP traffic"
  vpc_id = "vpc-0d0f87f5d80c69ffa"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}