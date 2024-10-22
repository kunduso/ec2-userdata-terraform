[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/) [![GitHub pull-requests closed](https://img.shields.io/github/issues-pr-closed/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/pull/) [![GitHub pull-requests](https://img.shields.io/github/issues-pr/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/pull/) 
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/kunduso/ec2-userdata-terraform)](https://github.com/kunduso/ec2-userdata-terraform/issues?q=is%3Aissue+is%3Aclosed) [![GitHub issues](https://img.shields.io/github/issues/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/issues/) 
![Image](https://skdevops.files.wordpress.com/2024/07/98-image-0.png)
## Motivation
*This GitHub repository contains multiple use cases of working with Terraform to provision Amazon EC2 instances. Specific Git branches separate these use cases. To read more about that, [click here](#other-use-cases-in-this-repository).*

Securely accessing and managing your Amazon EC2 instances for Windows has become a critical task for cloud engineers and IT administrators. In this [blog post](https://skundunotes.com/2024/07/27/secure-rdp-access-to-amazon-ec2-for-windows-leveraging-fleet-manager-and-session-manager/), I explored how you can leverage AWS Systems Manager's Fleet Manager to remotely connect to your EC2 instances using the familiar Remote Desktop Protocol (RDP), without the need for complex network configurations or exposing your instances to the public internet.

This repository contains the Terraform code to provision an Amazon EC2 instance for Windows with secure RDP access using AWS Systems Manager's Fleet Manager. The code demonstrates how to set up the necessary AWS services, including VPC Endpoints, security groups, and IAM policies, to enable this secure remote access solution.


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
|1.|Add an Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-amazon-ec2/ReadMe.md|
|2.|Add a `user_data` script to an Amazon EC2 instance| https://github.com/kunduso/ec2-userdata-terraform/blob/add-userdata/ReadMe.md|
|3.|Attach an AWS IAM role to an Amazon EC2 instance| https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role/ReadMe.md|
|4.|Install AWS.Tools module for PowerShell on Amazon EC2 instance running Windows Server using `user_data` script| https://github.com/kunduso/ec2-userdata-terraform/blob/add-aws.tools-powershell-to-userdata/ReadMe.md|
|5.|Install AWS CLI on an Amazon EC2 instance running Windows Server using `user_data` script|https://github.com/kunduso/ec2-userdata-terraform/blob/add-awscli-to-userdata/ReadMe.md|
|6.|Manage sensitive variables in Amazon EC2 with AWS Systems Manager Parameter Store|https://github.com/kunduso/ec2-userdata-terraform/blob/add-ssm-parameter/ReadMe.md|
|7.|Download Amazon S3 bucket contents to Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-s3-access/ReadMe.md|
|8.|Access AWS Secrets Manager secret from Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/access-secrets-python/ReadMe.md|
|9.|Create an Amazon EC2 instance with Session Manager access|https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role-for-session-manager/ReadMe.md|
|10.|Install and configure CloudWatch Logs agent on Amazon EC2 instance for Windows using user data|https://github.com/kunduso/ec2-userdata-terraform/blob/add-cloudwatch-agent/ReadMe.md|
|11.|Create an Amazon EC2 instance using Terraform with Session Manager access using VPC Endpoint|https://github.com/kunduso/ec2-userdata-terraform/blob/add-vpc-endpoint/ReadMe.md|
|12.|Install and configure CloudWatch Logs agent on Amazon EC2 instance for Linux using user data|https://github.com/kunduso/ec2-userdata-terraform/tree/add-cloudwatch-agent-linux-ec2/ReadMe.md

## License
This code is released under the Unlincse License. See [LICENSE](LICENSE).