# Create the AWS Organization
resource "aws_organizations_organization" "org" {
  feature_set = "ALL" # Or "CONSOLIDATED_BILLING"
}

# Create Organizational Units
resource "aws_organizations_organizational_unit" "test" {
  name      = "test_ou_setup"
  parent_id = aws_organizations_organization.org.roots[0].id
}