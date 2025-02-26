provider "aws" {
    region = "us-east-1"  
}

resource "aws_iam_user" "munna" {
    name = "munna"
  
}

resource "aws_iam_user_policy_attachment" "munna_permission" {
    user = aws_iam_user.munna.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    
}

resource "aws_iam_group" "Testing" {
    name = "Testing"
}

resource "aws_iam_group_policy_attachment" "Testing_permission" {
   group      = aws_iam_group.Testing.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
   depends_on = [aws_iam_group.Testing]
 }

resource "aws_iam_user_group_membership" "Testing_munna" {
  user   = aws_iam_user.munna.name
  groups = [aws_iam_group.Testing.name]
}

# for multiple IAM users created using Terraform

# resource "user_names" "users" {
#     for_each = toset(var.user_names)
#     name = each.value
  
# }
