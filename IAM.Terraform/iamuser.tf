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