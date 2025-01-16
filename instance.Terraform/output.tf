output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.newinstance.public_ip
}

output "security_group_id" {
  description = "The ID of the Security Group"
  value       = aws_security_group.new_sg.id
}



