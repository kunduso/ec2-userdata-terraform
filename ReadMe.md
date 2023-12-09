[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/)[![GitHub pull-requests closed](https://img.shields.io/github/issues-pr-closed/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/pull/)[![GitHub pull-requests](https://img.shields.io/github/issues-pr/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/pull/)
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/kunduso/ec2-userdata-terraform)](https://github.com/kunduso/ec2-userdata-terraform/issues?q=is%3Aissue+is%3Aclosed)[![GitHub issues](https://img.shields.io/github/issues/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/issues/)
![Image](https://skdevops.files.wordpress.com/2021/12/59-image-1.png)
## Motivation
I required a few files and folders on an Amazon EC2 instance as part of the provisioning process. So, the objective was to upload these files and folders into an Amazon S3 bucket and download them from the Amazon EC2 instance with the assistance of the user data script and Terraform.
<br />I have supporting documentation on my note at: [download-aws-s3-bucket-into-an-ec2-instance-in-5-steps-using-user-data-and-terraform](https://skundunotes.com/2021/12/17/download-aws-s3-bucket-into-an-ec2-instance-in-5-steps-using-user-data-and-terraform/)

## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.
<br />I created an Amazon EC2 key pair (format: pem) for Windows Instance by following the guidance at [-create ec2-key-pair.](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/create-key-pairs.html#having-ec2-create-your-key-pair)
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review the code, especially the `iamrole.tf` and `user_data.tpl` file to understand the idempotent approach towards every step, whether it is creating a folder, renaming the virtual machine or installing a windows feature.
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
|5.|Install AWS CLI on an Amazon EC2 instance running Windows Server using `user_data` script|https://github.com/kunduso/ec2-userdata-terraform/blob/add-awscli-to-userdata/ReadMe.md|
|6.|Create an Amazon EC2 instance with Session Manager access|https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role-for-session-manager/ReadMe.md|
|7.|Manage sensitive variables in Amazon EC2 with AWS Systems Manager Parameter Store|https://github.com/kunduso/ec2-userdata-terraform/blob/add-ssm-parameter/ReadMe.md|
|8.|Access AWS Secrets Manager secret from Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/access-secrets-python/ReadMe.md|

## License
This code is released under the Unlincse License. See [LICENSE](LICENSE).