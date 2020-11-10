resource "aws_iam_group" "app_users" {
  name = "app_users"
}

resource "aws_iam_user" "XXX" {
  name = "XXX"
}

resource "aws_iam_group_membership" "app_users" {
  name  = "app_users"
  users = [aws_iam_user.XXX.name]
  group = aws_iam_group.app_users.name
}

resource "aws_iam_group_policy_attachment" "app_user_attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMUserChangePassword"
  ])

  policy_arn = each.value
  group      = "app_users"
}
