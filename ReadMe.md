![Image](https://skdevops.files.wordpress.com/2021/11/57.image-1.png)
## Motivation
I was under the impression that all AWS EC2 instances have the latest version of AWS CLI installed. So, I was in for a pretty shock when I discovered that is not always the case. However, I was required to use the AWS CLI, so I automated the installation with the EC2 user data script and Terraform. Since this was an EC2 with Windows OS, I proceeded with installing the **AWS.Tools module for PowerShell.**
<br />I have supporting documentation on my note at: [install-aws-tools-module-for-powershell-on-aws-ec2-using-user-data-and-terraform](https://skundunotes.com/2021/11/19/install-aws-tools-module-for-powershell-on-aws-ec2-using-user-data-and-terraform/)
## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review the code, especially the `user_data.tpl` file to understand the idempotent approach towards every step, whether it is creating a folder, renaming the virtual machine or installing a windows feature.
<br />
<br />Next, run `terraform init` 
<br />Then run `terraform plan`
<br />And finally run `terraform apply`
