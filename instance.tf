provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "myserver" {
    ami = "ami-0e2c8caa4b6378d8c"
    key_name = "shell-keynew"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-0b66cddd21554c10c"]
    availability_zone = "us-east-1a"
    tags = {
        name = "vishal"
        env = "dev"
    }
    user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              EOF

  
}
