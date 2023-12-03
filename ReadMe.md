[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/)
![Image](https://skdevops.files.wordpress.com/2023/12/53-image-0.png)
## Motivation
*This GitHub repository contains multiple use cases of working with Terraform to provision Amazon EC2 instances. Specific Git branches separate these use cases. To read more about that, [click here](#other-use-cases-in-this-repository).*

In this repository, I have the terraform code to create an AWS EC2 instance using infrastructure as code approach.
<br />I have supporting documentation on my note at: [create-aws-ec2-using-terraform](https://skundunotes.com/2021/11/01/create-aws-ec2-using-terraform/)
## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.
<br />I created an Amazon EC2 key pair (format: pem) for Windows Instance by following the guidance at [-create ec2-key-pair.](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/create-key-pairs.html#having-ec2-create-your-key-pair)
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review the code, especially the `ec2.tf` file and update the `ingress cidr_blocks` to allow access from your local network.
<br />To find your IP address, open command prompt and key in: `curl ifconfig.me`
<br />The value is your local machine's IP address. If you want to restrict access to only your machine, update teh `ingress cidr_blocks` with that value and append a `/32` to it. Else, you could also go up the range and enable access from a wider set of machines.
<br />Next run `terraform init` 
<br />Then run `terraform plan`
<br />And finally run `terraform apply`

## Other use-cases in this repository
There are eight other branches in this repository discussing other use-cases:
<br />
<br />
No.|Use-Case | Branch
|--- |--- |--- |
|1.|Add a `user_data` script to an Amazon EC2 isntance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-userdata/ReadMe.md|
|2.| Install AWS.Tools module for PowerShell on Amazon EC2 instance running Windows Server using `user_data` script| https://github.com/kunduso/ec2-userdata-terraform/blob/add-aws.tools-powershell-to-userdata/ReadMe.md|
|3.|Install AWS CLI on an Amazon EC2 instance running Windows Server using `user_data` script|https://github.com/kunduso/ec2-userdata-terraform/blob/add-awscli-to-userdata/ReadMe.md|
|4.|Attach an AWS IAM role to an Amazon EC2 instance| https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role/ReadMe.md|
|5.|Create an Amazon EC2 instance with Session Manager access|https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role-for-session-manager/ReadMe.md|
|6.|Download Amazon S3 bucket contents to Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-s3-access/ReadMe.md|
|7.|Manage sensitive variables in Amazon EC2 with AWS Systems Manager Parameter Store|https://github.com/kunduso/ec2-userdata-terraform/blob/add-ssm-parameter/ReadMe.md|
|8.|Access AWS Secrets Manager secret from Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/access-secrets-python/ReadMe.md|