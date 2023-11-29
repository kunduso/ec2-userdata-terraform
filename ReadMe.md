[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/)
![Image](https://skdevops.files.wordpress.com/2023/11/86-image-0.png)
## Motivation
*This GitHub repository contains multiple use cases of working with Terraform to provision Amazon EC2 instances. Specific Git branches separate these use cases. To read more about that, [click here](#other-use-cases-in-this-repository).*

 <br />I have the Terraform code in this branch to access the AWS Secrets Manager secret value using Python from an Amazon EC2 instance.
 <br />For that, I:
<br />1. Created a couple of secrets and stored those inside AWS Secrets Manager secrets,
<br />2. created a couple of Amazon EC2 instances, and
<br />3. created Python files inside the Amazon EC2 instances using the user data script to access the secret.

<br />I have detailed documentation on my note at: [access-aws-secrets-manager-secret-from-amazon-ec2-instance-using-python](https://skundunotes.com/2023/11/27/access-aws-secrets-manager-secret-from-amazon-ec2-instance-using-python/)
## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them and updated the [.gitignore file](.gitignore) so the file does not get committed to this repository.
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review all the `terraform` code, starting with the network block discussed in [vpc.tf](vpc.tf).
<br />Before you run this code, add a `backend.tf` if there are multiple team members working in the same code repository to avoid accidental overrides.
<br />Next run `terraform init` 
<br />Then run `terraform plan`
<br />And finally run `terraform apply`

## Other use-cases in this repository
There are eight other branches in this repository discussing other use-cases:
<br />
<br />
No.|Use-Case | Branch
|--- |--- |--- |
|1.|Create an Amazon EC2 instance running Windows Server|https://github.com/kunduso/ec2-userdata-terraform/blob/add-ec2/ReadMe.md|
|2.|Add a `user_data` script to an Amazon EC2 isntance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-userdata/ReadMe.md|
|3.| Install AWS.Tools module for PowerShell on Amazon EC2 instance running Windows Server using `user_data` script| https://github.com/kunduso/ec2-userdata-terraform/blob/add-aws.tools-powershell-to-userdata/ReadMe.md|
|4.|Install AWS CLI on an Amazon EC2 instance running Windows Server using `user_data` script|https://github.com/kunduso/ec2-userdata-terraform/blob/add-awscli-to-userdata/ReadMe.md|
|5.|Attach an AWS IAM role to an Amazon EC2 instance| https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role/ReadMe.md|
|6.|Create an Amazon EC2 instance with Session Manager access|https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role-for-session-manager/ReadMe.md|
|7.|Download Amazon S3 bucket contents to Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-s3-access/ReadMe.md|
|8.|Manage sensitive variables in Amazon EC2 with AWS Systems Manager Parameter Store|https://github.com/kunduso/ec2-userdata-terraform/blob/add-ssm-parameter/ReadMe.md|