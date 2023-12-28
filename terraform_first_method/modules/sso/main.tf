# Create a role in each child account for cross-account access
resource "aws_iam_role" "cross_account_role" {
  for_each = toset(["account-id-1", "account-id-2"]) # List of child account IDs

  name = "CrossAccountAccessRole"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        AWS = "arn:aws:iam::${aws_organizations_organization.org.master_account_id}:root"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  for_each   = aws_iam_role.cross_account_role
  role       = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
