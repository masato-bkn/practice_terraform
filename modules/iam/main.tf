resource "aws_iam_user" "app_user" {
  name          = "masato"
  force_destroy = true
}

# data "aws_iam_policy" "app_user_policy" {
#   arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
# }
