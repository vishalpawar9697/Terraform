output "iam_user_name" {
    value = aws_iam_user.munna.name
  
}

output "login_profile_created" {
    value = "aws_iam_user_login_profile.munna_login_profile.id"
  
}
 
output "iam_group_name" {
    value = aws_iam_group.Testing.name
  
}