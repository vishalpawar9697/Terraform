#block_type resource_type resource_name {
#configration files
#}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "newinstance" {
    ami = "ami-01816d07b1128cd2d"
    key_name = "shell-keynew" 
    instance_type = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.new_sg.id ]
    user_data              = <<-EOF
                          #!/bin/bash
                          sudo apt-get update -y
                          sudo apt install -y java-1.8.0-openjdk
                          sudo apt install -y wget
                          curl -O https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz
                          tar -xzf apache-tomcat-9.0.41.tar.gz
                          sudo mv apache-tomcat-9.0.41 /usr/local/tomcat9
                          sudo chmod +x /usr/local/tomcat9/bin/*.sh
                          sudo /usr/local/tomcat9/bin/startup.sh
                          EOF
                    
    tags = {
      Name = "vishal-instance"
      env = "dev"
    }
  
}

resource "aws_security_group" "new_sg" {
  name        = "new_sg"
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