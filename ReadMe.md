[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/) [![GitHub pull-requests closed](https://img.shields.io/github/issues-pr-closed/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/pull/) [![GitHub pull-requests](https://img.shields.io/github/issues-pr/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/pull/) 
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/kunduso/ec2-userdata-terraform)](https://github.com/kunduso/ec2-userdata-terraform/issues?q=is%3Aissue+is%3Aclosed) [![GitHub issues](https://img.shields.io/github/issues/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/issues/) 
![Image](https://skdevops.files.wordpress.com/2023/08/81-image-0.png)
## Motivation
*This GitHub repository contains multiple use cases of working with Terraform to provision Amazon EC2 instances. Specific Git branches separate these use cases. To read more about that, [click here](#other-use-cases-in-this-repository).*

I came across a use cases where I wanted to connect to an Amazon EC2 instance without opening up ingress ports (SSH or Remote Desktop) in the Amazon EC2 security group. I learned about the capability of attaching the AWS managed policy `arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore` to the Amazon EC2 instance to manage access from the AWS Console.

<br />I have supporting documentation on my note at: [Provision an Amazon EC2 instance with Session Manager access using Terraform.](https://skundunotes.com/2023/08/27/provision-an-amazon-ec2-instance-with-session-manager-access-using-terraform/)
## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.

## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review the code, especially the `iamrole.tf` and `ec2.tf` file to understand all the concepts associated with creating an IAM role, attaching the role to the AWS managed policy, creating an IAM instance profile with the IAM role and finally attaching the IAM instance profile to the Amazon EC2 instance.
<br />
<br />Next, run `terraform init`
<br />Then run `terraform plan`
<br />And finally run `terraform apply`

## Other use-cases in this repository
There are other branches in this repository discussing other use-cases:
<br />
<br />
No.|Use-Case | Branch
|--- |--- |--- |
|1.|Add an Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-amazon-ec2/ReadMe.md|
|2.|Add a `user_data` script to an Amazon EC2 instance| https://github.com/kunduso/ec2-userdata-terraform/blob/add-userdata/ReadMe.md|
|3.|Attach an AWS IAM role to an Amazon EC2 instance| https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role/ReadMe.md|
|4.|Install AWS.Tools module for PowerShell on Amazon EC2 instance running Windows Server using `user_data` script| https://github.com/kunduso/ec2-userdata-terraform/blob/add-aws.tools-powershell-to-userdata/ReadMe.md|
|5.|Install AWS CLI on an Amazon EC2 instance running Windows Server using `user_data` script|https://github.com/kunduso/ec2-userdata-terraform/blob/add-awscli-to-userdata/ReadMe.md|
|6.|Manage sensitive variables in Amazon EC2 with AWS Systems Manager Parameter Store|https://github.com/kunduso/ec2-userdata-terraform/blob/add-ssm-parameter/ReadMe.md|
|7.|Download Amazon S3 bucket contents to Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-s3-access/ReadMe.md|
|8.|Access AWS Secrets Manager secret from Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/access-secrets-python/ReadMe.md|
|9.|Create an Amazon EC2 instance using Terraform with Session Manager access using VPC Endpoint|https://github.com/kunduso/ec2-userdata-terraform/blob/add-vpc-endpoint/ReadMe.md|
|10.|Install and configure CloudWatch Logs agent on Amazon EC2 instance for Windows using user data|https://github.com/kunduso/ec2-userdata-terraform/blob/add-cloudwatch-agent/ReadMe.md|
|11.|Secure RDP Access to Amazon EC2 for Windows: Leveraging Fleet Manager and Session Manager|https://github.com/kunduso/ec2-userdata-terraform/blob/enable-rdp-session-manager/ReadMe.md|
|12.|Install and configure CloudWatch Logs agent on Amazon EC2 instance for Linux using user data|https://github.com/kunduso/ec2-userdata-terraform/tree/add-cloudwatch-agent-linux-ec2/ReadMe.md

## License
This code is released under the Unlincse License. See [LICENSE](LICENSE).