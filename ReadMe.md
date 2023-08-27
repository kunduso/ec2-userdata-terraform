![Image](https://skdevops.files.wordpress.com/2023/08/81-image-0.png)
## Motivation
I came across a use cases where I wanted to connect to an Amazon EC2 instance without opening up ports (SSH or Remote Desktop). I learned about the capability of attaching the AWS managed policy `arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore` to the EC2 instance to manage access from the AWS Console.

<br />I have supporting documentation on my note at: [Provision an Amazon EC2 instance with Session Manager access using Terraform.](https://skundunotes.com/2023/08/27/provision-an-amazon-ec2-instance-with-session-manager-access-using-terraform/)
## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review the code, especially the `iamrole.tf` and `ec2.tf` file to understand all the concepts associated with creating an IAM role, attaching the role to the AWS managed policy, creating an IAM instance profile with the IAM role and finally attaching the IAM instance profile to the AWS EC2 instance.
<br />
<br />Next, run `terraform init` 
<br />Then run `terraform plan`
<br />And finally run `terraform apply`