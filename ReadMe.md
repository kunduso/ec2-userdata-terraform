[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/)[![GitHub pull-requests closed](https://img.shields.io/github/issues-pr-closed/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/pull/)[![GitHub pull-requests](https://img.shields.io/github/issues-pr/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/pull/)
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/kunduso/ec2-userdata-terraform)](https://github.com/kunduso/ec2-userdata-terraform/issues?q=is%3Aissue+is%3Aclosed)[![GitHub issues](https://img.shields.io/github/issues/kunduso/ec2-userdata-terraform)](https://GitHub.com/kunduso/ec2-userdata-terraform/issues/)
![Image](https://skdevops.files.wordpress.com/2021/11/56-image-1.png)
## Motivation
*This GitHub repository contains multiple use cases of working with Terraform to provision Amazon EC2 instances. Specific Git branches separate these use cases. To read more about that, [click here](#other-use-cases-in-this-repository).*

If you have worked with Amazon EC2 user data, you'd have noticed a shortcoming in the approach -the inability to pass command-line arguments to the user data script at run time.<br />
<br />Let me explain why I believe that to be a problem. User data is a capability associated with an Amazon EC2 instance as part of the provisioning process. Due to its nature, user data is an ideal candidate to carry the load of server provisioning steps like:<br />

1. Installing 3rd party software.<br />
2. Configuring permissions and access.<br />
3. Installing and configuring windows features.<br />
4. Installing endpoint agents, etc.<br />

A few of these steps involve sharing secure credentials as part of authentication. Due to its inability to work with command-line arguments, the user data script requires that these credentials be provided inside the script. That means anyone who has access to the user data script in the Amazon EC2 instance also has access to the credentials.<br />
That is not desirable, and there is a way around the problem -AWS System Manager parameter store.

Per AWS-Docs, -Parameter Store (is) a capability of AWS Systems Manager, (that) provides secure, hierarchical storage for configuration data management and secrets management. More information is available at [AWS Systems Manager Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html).<br />

<br />In this Github repo and branch I have a working copy of how to manage secure variables using AWS SSM parameter store using Terraform. I also have supporting documentation on my note at: [Manage sensitive variables in Amazon EC2 user data with Terraform and PowerShell.](https://skundunotes.com/2021/11/17/manage-sensitive-variables-in-aws-ec2-user-data-with-terraform/)

## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.
<br />I created an Amazon EC2 key pair (format: pem) for Windows Instance by following the guidance at [-create ec2-key-pair.](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/create-key-pairs.html#having-ec2-create-your-key-pair)
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review the code, especially the `user_data.tpl`, `ssm_parameter.tf`, `iamrole.tf` and `ec2.tf` file to understand all the concepts to (i) store the sensitive credentials in the ssm-parameter store, (ii) associate an IAM role to the Amazon EC2 instance that had permission to read from the parameter store, (iii) pass the parameter store variable name to the Amazon EC2 user data script to decrypt and (iv) add the capability in the user data script to read from the parameter store.
<br />
<br />Next, run `terraform init`
<br />Then run `terraform plan`

<br />And finally run `terraform apply -var SecureVariableOne=ThisIsASecureValue`

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
|7.|Download Amazon S3 bucket contents to Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/add-s3-access/ReadMe.md|
|8.|Access AWS Secrets Manager secret from Amazon EC2 instance|https://github.com/kunduso/ec2-userdata-terraform/blob/access-secrets-python/ReadMe.md|
|9.|Create an Amazon EC2 instance using Terraform with Session Manager access using VPC Endpoint|https://github.com/kunduso/ec2-userdata-terraform/blob/add-vpc-endpoint/ReadMe.md|

## License
This code is released under the Unlincse License. See [LICENSE](LICENSE).