![Image](https://skdevops.files.wordpress.com/2021/11/55.image-1.png)
## Motivation
I came across two use cases where I required an AWS EC2 to assume an IAM role.
<br />Before I explored it, the concept was -assign a set of permissions to an EC2 instance to carry out a specific set of activities. Hence I created an AWS IAM policy file with a set of permissions/rules and assigned it to an AWS IAM role, which was then associated with an IAM instance profile that was then assumed by an EC2 instance. The EC2 instance was then able to perform a set of actions listed in the AWS IAM policy file.<br />
<br />**Generally, attaching an AWS IAM role to an EC2 instance is part of a more extensive use case.**<br />
<br />I have supporting documentation on my note at: [Attach IAM role to AWS EC2 instance using Terraform](https://skundunotes.com/2021/11/16/attach-iam-role-to-aws-ec2-instance-using-terraform/)
## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review the code, especially the `iamrole.tf` and `ec2.tf` file to understand all the concepts associated with creating an AWS policy file, creating an IAM role, attaching the role to the policy, creating an IAM instance profile with the IAM role and finally attaching the IAM instance profile to the AWS EC2 instance.
<br />
<br />Next, run `terraform init` 
<br />Then run `terraform plan`
<br />And finally run `terraform apply`