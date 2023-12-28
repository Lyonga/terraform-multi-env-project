resource "aws_organizations_policy" "scp_policy" {
  name        = "RestrictivePolicy"
  description = "Restricts terminating EC2, deleting EBS and Lambda, creating VPCs, and IAM roles"

  content = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Deny",
        Action    = [
          "ec2:TerminateInstances",  # Denies terminating EC2 instances
          "ec2:DeleteVolume",        # Denies deleting EBS volumes
          "lambda:DeleteFunction",   # Denies deleting Lambda functions
          "ec2:CreateVpc",           # Denies creating VPCs
          "iam:CreateRole"           # Denies creating IAM roles
        ],
        Resource  = "*"
      }
    ]
  })
}

resource "aws_organizations_policy_attachment" "scp_attach" {
  policy_id = aws_organizations_policy.scp_policy.id
  target_id = target_id = aws_organizations_organizational_unit.test.id
}

resource "aws_organizations_policy" "scp" {
name        = var.scp_name
description = var.scp_description
content     = var.scp_content
}

resource "aws_organizations_policy_attachment" "scp_attach" {
policy_id = aws_organizations_policy.scp.id
target_id = var.target_ou_id
}
