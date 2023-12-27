[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/)[![GitHub pull-requests closed](https://img.shields.io/github/issues-pr-closed/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/pull/)[![GitHub pull-requests](https://img.shields.io/github/issues-pr/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/pull/)
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/kunduso/ec2-userdata-terraform)](https://github.com/kunduso/ec2-userdata-terraform/issues?q=is%3Aissue+is%3Aclosed)[![GitHub issues](https://img.shields.io/github/issues/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/issues/)
![Image](https://skdevops.files.wordpress.com/2021/12/58-image-1.png)
## Motivation
*This GitHub repository contains multiple use cases of working with Terraform to provision Amazon EC2 instances. Specific Git branches separate these use cases. To read more about that, [click here](#other-use-cases-in-this-repository).*

I was under the impression that all Amazon EC2 instances have the latest version of AWS CLI installed. So, I was in for a shock when I discovered that is not always the case. However, I was required to use the AWS CLI, so I automated the installation with the EC2 user data script and Terraform.
<br />I have supporting documentation on my note at: [install-aws-cli-on-a-windows-ec2-instance-using-terraform-and-user-data](https://skundunotes.com/2021/12/07/install-aws-cli-on-a-windows-ec2-instance-using-terraform-and-user-data/)

## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.
<br />I created an Amazon EC2 key pair (format: pem) for Windows Instance by following the guidance at [-create ec2-key-pair.](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/create-key-pairs.html#having-ec2-create-your-key-pair)
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review the code, especially the `user_data.tpl` file to understand the idempotent approach towards every step, whether it is creating a folder, renaming the virtual machine or installing a windows feature.
<br />
<br />Next, run `terraform init`
<br />Then run `terraform plan`
<br />And finally run `terraform apply`

## Other use-cases in this repository
There are eight other branches in this repository discussing other use-cases:
<br />
<br />
No.|Use-Case | Branch
|--- |--- |--- |
|1.|Add an Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform#readme|
|2.|Add a `user_data` script to an Amazon EC2 instance| https://github.com/kunduso/ec2-userdata-terraform/blob/add-userdata/ReadMe.md|
|3.|Attach an AWS IAM role to an Amazon EC2 instance| https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role/ReadMe.md|
|4.| Install AWS.Tools module for PowerShell on Amazon EC2 instance running Windows Server using `user_data` script| https://github.com/kunduso/ec2-userdata-terraform/blob/add-aws.tools-powershell-to-userdata/ReadMe.md|
|5.|Manage sensitive variables in Amazon EC2 with AWS Systems Manager Parameter Store|https://github.com/kunduso/ec2-userdata-terraform/blob/add-ssm-parameter/ReadMe.md|
|6.|Create an Amazon EC2 instance with Session Manager access|https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role-for-session-manager/ReadMe.md|
|7.|Download Amazon S3 bucket contents to Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-s3-access/ReadMe.md|
|8.|Access AWS Secrets Manager secret from Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/access-secrets-python/ReadMe.md|
|9.|Create an Amazon EC2 instance using Terraform with Session Manager access using VPC Endpoint|https://github.com/kunduso/ec2-userdata-terraform/blob/add-vpc-endpoint/ReadMe.md|

## License
This code is released under the Unlincse License. See [LICENSE](LICENSE).