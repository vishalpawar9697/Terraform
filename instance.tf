#block_type resource_type resource_name {
#configration files
#}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "new_instance" {
    ami = "ami-0e2c8caa4b6378d8c"
    key_name = "shell-keynew"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["aws_security_group.mysg.id"]
    depends_on = [ aws_security_group.mysg ]

    tags = {
        name = "vishal-instance"
    }
  
}

resource "aws_security_group" "mysg" {
  name        = "devops-sg"
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