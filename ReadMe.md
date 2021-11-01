![Image](https://skdevops.files.wordpress.com/2021/10/53.image-1-1.png)
## Motivation
One of the first components I created on AWS cloud was an EC2 instance by watching hands-on tutorials. Little did I know about the infrastructure bits that went behind that. In this repository, I have the terraform code to create two AWS EC2 instances using infrastructure as code approach.
<br />I have supporting documentation on my note at: [create-aws-ec2-using-terraform](https://skundunotes.com/2021/11/01/create-aws-ec2-using-terraform/)
## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review the code, especially the `ec2.tf` file and update the `ingress cidr_blocks` to allow access from your local network.
<br />To find your IP address, open command prompt and key in: `curl ifconfig.me`
<br />The value is your local machine's IP address. If you want to restrict access to only your machine, update teh `ingress cidr_blocks` with that value and append a `/32` to it. Else, you could also go up the range and enable access from a wider set of machines.
<br />Next run `terraform init` 
<br />Then run `terraform plan`
<br />And finally run `terraform apply`

## Interesting use-cases
If you want to have fun, try the following:
<br />Update the security group and see how it impacts your web access: remove the `egress` block.
<br />Update the route table and see how it impacts your web access: remove the `0.0.0.0/0` route.