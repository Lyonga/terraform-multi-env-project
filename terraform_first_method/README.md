How to structure a terraform environment.

Two methods to structure a terraform environment



Method 1 (Recommended)
Method 2 (Not the best)

Service Control Policies (SCPs) in AWS are used to set permission boundaries at the organizational level, rather than directly on individual IAM roles or groups. They are a powerful tool in AWS Organizations for managing permissions across multiple AWS accounts. Let's clarify their usage:

Main Use of SCPs:
Organization-Level Permission Control:

SCPs are applied at the AWS Organization or Organizational Unit (OU) level. They govern what actions are allowed or denied in all accounts under that Organization or OU.
They essentially set the maximum permissions that can be granted in the accounts they apply to.
Guardrails for Accounts:

SCPs act as guardrails that restrict what actions account administrators can delegate to IAM users and roles within their accounts.
For example, an SCP can prevent all accounts in a production OU from deleting EC2 instances, regardless of the permissions individual IAM users or roles have.
Compliance and Security:

SCPs help ensure compliance with company policies across all AWS accounts.
They provide a way to enforce security best practices and prevent actions that could lead to security risks.
SCP vs IAM Role Permissions:
IAM Role Permissions:

Define what actions the role can perform within an individual AWS account.
Are granted directly to IAM roles or users within a specific account.
SCP Limitations:

Do not grant permissions; they only restrict permissions.
Cannot be used to grant permissions to a group or role directly. Instead, they limit what permissions can be effective within accounts.
Example Scenario:
You have an OU for production accounts and another for development accounts.
You apply an SCP to the production OU that prohibits actions like s3:DeleteBucket across all accounts in that OU.
Even if an IAM role in one of these production accounts has a policy allowing s3:DeleteBucket, the SCP overrides this and prevents the action.
Conclusion:
SCPs are essential for centralized control and security in a multi-account AWS environment. They provide a way to enforce organizational policies and prevent accounts from performing actions that could be harmful or non-compliant with company-wide policies. While they don't directly set permissions for individual roles or groups, they create a top-level permission boundary within which all account-level permissions must operate.



####
Integrating AWS Single Sign-On (SSO) with an identity provider (IdP) like Okta and using Service Control Policies (SCPs) at the Organizational Unit (OU) level for a Landing Zone and account access involves several steps. The goal is to ensure that users and groups managed through Okta can access AWS accounts with permissions governed by SCPs. Here's an overview of how these components work together:

1. Set Up AWS Organizations and OUs:
   Create your AWS Organization and establish OUs that reflect your organizational structure (e.g., Development, Production).
   Apply SCPs at the OU level to define and enforce permissions boundaries for all accounts within each OU.
2. Configure AWS SSO with Okta Integration:
   Enable AWS SSO in your AWS Organization.
   Integrate AWS SSO with Okta:
   In AWS SSO, choose an external identity provider and follow the setup process to integrate with Okta.
   In Okta, configure AWS as an application and establish a trust relationship using SAML.
3. Create Users and Groups in Okta:
   Define users and groups in Okta, aligning them with your organization’s roles and responsibilities.
   Groups in Okta might reflect roles like DevOps, ReadOnly, and Support.
4. Map Okta Groups to AWS SSO Roles:
   In AWS SSO, assign Okta groups to AWS SSO roles. Each role corresponds to a set of permissions in AWS.
   These roles are different from IAM roles; they're used in AWS SSO to grant access to AWS accounts and resources.
5. Provision Access to AWS Accounts:
   Use AWS SSO to grant Okta groups access to specific AWS accounts.
   When a user from Okta logs into AWS SSO, they can assume the roles they’ve been granted in the accounts they have access to.
6. SCP Enforcement:
   SCPs applied at the OU level govern the maximum permissions available to users within those accounts, regardless of their individual permissions.
   Even if a user has broad permissions in an AWS SSO role, SCPs can restrict their ability to perform certain actions.
   Best Practices:
   Least Privilege: Assign users and groups in Okta only the necessary permissions.
   Role Segregation: Create distinct roles in AWS SSO for different responsibilities and map them appropriately to Okta groups.
   Regular Audits: Regularly review and audit SCPs, AWS SSO roles, and Okta configurations to ensure they align with your security and compliance requirements.
   Automate and Document: Automate the setup as much as possible and maintain clear documentation for your AWS and Okta integration.
   Conclusion
   By combining AWS SSO with Okta, you can streamline user access management across your AWS environment, while SCPs ensure that permissions within AWS accounts are controlled and comply with your organization's policies. This setup provides a robust, scalable, and secure approach to manage access in a multi-account AWS environment, particularly in the context of a Landing Zone architecture