[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/)
![Image](https://skdevops.files.wordpress.com/2021/11/54.image-1.png)
## Motivation
*This GitHub repository contains multiple use cases of working with Terraform to provision Amazon EC2 instances. Specific Git branches separate these use cases. To read more about that, [click here](#other-use-cases-in-this-repository).*

Just because an application is hosted on a virtual machine does not mean that installing software, enabling features, and converting it to a useable component of an environment has to happen manually and, in the process, take longer. Over the last few years, I have learned of a few tools like Terraform that would help manage a cloud resource (like Amazon EC2) with a few lines of HCL code. But what after that? Merely provisioning a virtual machine is not enough. Without installing specific software and/or enabling certain features (I’m talking about Windows OS here), the provisioned virtual machine won’t be usable.
<br />That is when UserData comes into the picture.<br />
<br />**User data is the answer to automating all (or as much as possible) the manual steps applied once an Amazon EC2 is provisioned to host an application.**<br />
<br />I have supporting documentation on my note at: [working-with-aws-ec2-user-data-and-terraform](https://skundunotes.com/2021/11/07/working-with-aws-ec2-user-data-and-terraform/)
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
|1.|Add an Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-userdata/ReadMe.md|
|2.| Install AWS.Tools module for PowerShell on Amazon EC2 instance running Windows Server using `user_data` script| https://github.com/kunduso/ec2-userdata-terraform/blob/add-aws.tools-powershell-to-userdata/ReadMe.md|
|3.|Install AWS CLI on an Amazon EC2 instance running Windows Server using `user_data` script|https://github.com/kunduso/ec2-userdata-terraform/blob/add-awscli-to-userdata/ReadMe.md|
|4.|Attach an AWS IAM role to an Amazon EC2 instance| https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role/ReadMe.md|
|5.|Create an Amazon EC2 instance with Session Manager access|https://github.com/kunduso/ec2-userdata-terraform/blob/add-iam-role-for-session-manager/ReadMe.md|
|6.|Download Amazon S3 bucket contents to Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-s3-access/ReadMe.md|
|7.|Manage sensitive variables in Amazon EC2 with AWS Systems Manager Parameter Store|https://github.com/kunduso/ec2-userdata-terraform/blob/add-ssm-parameter/ReadMe.md|
|8.|Access AWS Secrets Manager secret from Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/access-secrets-python/ReadMe.md|

## License
This code is released under the Unlincse License. See [LICENSE](LICENSE).