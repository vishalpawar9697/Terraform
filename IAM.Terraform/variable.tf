# Define a list of user names
variable "user_names" {
  type    = list(string)
  default = ["vijay", "rajiv", "kalin"]  # List of multiple IAM user names
}