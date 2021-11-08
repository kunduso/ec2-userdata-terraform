![Image](https://skdevops.files.wordpress.com/2021/11/54.image-1.png)
## Motivation
Just because an application is hosted on a virtual machine does not mean that installing software, enabling features, and converting it to a useable component of an environment has to happen manually and, in the process, take longer. Over the last few years, I have learned of a few tools like Terraform that would help manage a cloud resource (like EC2) with a few lines of HCL code. But what after that? Merely provisioning a virtual machine is not enough. Without installing specific software and/or enabling certain features (I’m talking about Windows OS here), the provisioned virtual machine won’t be usable.
<br />That is when UserData comes into the picture.<br />
<br />**User data is the answer to automating all (or as much as possible) the manual steps applied once an EC2 is provisioned to host an application.**<br />
<br />I have supporting documentation on my note at: [working-with-aws-ec2-user-data-and-terraform](https://skundunotes.com/2021/11/07/working-with-aws-ec2-user-data-and-terraform/)
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
