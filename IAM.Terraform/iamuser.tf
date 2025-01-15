provider "aws" {
    region = "us-east-1"  
}

resource "aws_iam_user" "munna" {
    name = "munna"
  
}

resource "aws_iam_user_login_profile" "munna_login_profile" {
    user = "aws_iam_user.munna.name"
    password = "munna@123!"
    password_reset_required = false
  
}