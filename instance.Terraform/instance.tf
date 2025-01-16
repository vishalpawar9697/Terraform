# Provider block for AWS
provider "aws" {
  region = var.region
}

# Security group definition
resource "aws_security_group" "new_sg" {
  name        = "new_sg"
  description = "Allow HTTP traffic"
  vpc_id      = var.vpc_id  # It's better to reference a VPC resource dynamically

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port   = 22
  to_port     = 22
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
}

# EC2 instance definition
resource "aws_instance" "newinstance" {
  ami                    = var.ami_id
  key_name               = var.key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.new_sg.id]  # Referencing the security group created above
  user_data              = <<-EOF
                          #!/bin/bash
                          sudo apt-get update -y
                          sudo apt-get install openjdk-11-jdk -y
                          curl -O https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz
                          tar -xzf apache-tomcat-9.0.41.tar.gz
                          sudo mv apache-tomcat-9.0.41 /usr/local/tomcat9
                          sudo chmod +x /usr/local/tomcat9/bin/*.sh
                          sudo /usr/local/tomcat9/bin/startup.sh
                          EOF
  tags = {
    Name = "vishal-instance"
    env  = "dev"
  }
}

