resource "aws_iam_user" "user" {
  name = "test-user"
}

resource "aws_iam_group" "read_only" {
  name = "ReadOnly"
}

resource "aws_iam_group" "support" {
  name = "support"
}

resource "aws_iam_group" "devops" {
  name = "Devops"
}

resource "aws_iam_group_membership" "membership" {
  name = "test-membership"
  users = [aws_iam_user.user.name]
  groups = [
    aws_iam_group.read_only.name,
    aws_iam_group.support.name,
    aws_iam_group.devops.name
  ]
}
