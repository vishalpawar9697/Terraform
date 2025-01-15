resource "aws_iam_user_login_profile" "munna_profile" {
  user = "munna"
  lifecycle {
    prevent_destroy = false  # Allow the resource to be destroyed
  }
}

resource "aws_iam_user" "munna" {
  name = "munna"
  lifecycle {
    prevent_destroy = false  # Allow the resource to be destroyed
  }
}
