![Image](https://skdevops.files.wordpress.com/2021/12/59.image-1.png)
## Motivation
I required a few files and folders on an EC2 instance as part of the provisioning process. So, the objective was to upload these files and folders into an AWS S3 bucket and download them from the EC2 instance with the assistance of the user data script and Terraform.
<br />I have supporting documentation on my note at: [download-aws-s3-bucket-into-an-ec2-instance-in-5-steps-using-user-data-and-terraform](https://skundunotes.com/2021/12/17/download-aws-s3-bucket-into-an-ec2-instance-in-5-steps-using-user-data-and-terraform/)
## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review the code, especially the `iamrole.tf` and `user_data.tpl` file to understand the idempotent approach towards every step, whether it is creating a folder, renaming the virtual machine or installing a windows feature.
<br />
<br />Next, run `terraform init` 
<br />Then run `terraform plan`
<br />And finally run `terraform apply`
