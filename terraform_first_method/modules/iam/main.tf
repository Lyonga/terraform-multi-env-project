resource "aws_iam_role" "devops_role" {
  name = "DevOpsRole"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { "AWS": "arn:aws:iam::${var.aws_account_id}:root" },
      Action    = "sts:AssumeRole"
    }]
  })

  # Example policy attachment (adjust as needed)
  managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

resource "aws_iam_role" "readonly_role" {
  name = "ReadOnlyRole"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { "AWS": "arn:aws:iam::${var.aws_account_id}:root" },
      Action    = "sts:AssumeRole"
    }]
  })

  # Example policy attachment
  managed_policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

resource "aws_iam_role" "support_role" {
  name = "SupportRole"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { "AWS": "arn:aws:iam::${var.aws_account_id}:root" },
      Action    = "sts:AssumeRole"
    }]
  })

  # Define specific policies for support tasks
  # Example: Managed policy for viewing logs and monitoring
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess"
  ]
}
