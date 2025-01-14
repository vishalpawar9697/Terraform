#block_type resource_type resource_name {
#configration files
#}

provider "aws" {
    region = "us-east1"
}

resource "aws_instance" "myinstance" {
    ami = "ami-0e2c8caa4b6378d8c"
    key_name = "shell-keynew"
    instance_type = "t2.micro"
    vpc_security_group_ids = [ "sg-0004cad9b30fd750c" ]
    tags = {
        name = "myinstance"
    }
  
}
