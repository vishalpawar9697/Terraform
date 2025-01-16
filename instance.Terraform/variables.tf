variable "ami_id" {
  description = "The ID of the AMI to use"
  type        = string
  default = "ami-0e2c8caa4b6378d8c"
}
variable "key_name" {
    description = "this is private key"
    type = string
    default = "shell-keynew"
}
variable "instance_type" {
    description = "Type of ec2 instance"
    type = string
    default = "t2.micro"
}
variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"  # You can specify a default value
}

variable "vpc_id" {
    description = "this is default vpc"
    type = string
    default = "vpc-0d0f87f5d80c69ffa"
  
}