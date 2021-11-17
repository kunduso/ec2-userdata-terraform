![Image](https://skdevops.files.wordpress.com/2021/11/56.image-1.png)
## Motivation
If you have worked with EC2 user data, you'd have noticed a shortcoming in the approach -the inability to pass command-line arguments to the user data script at run time.<br />
<br />Let me explain why I believe that to be a problem. User data is a capability associated with an AWS EC2 instance as part of the provisioning process. Due to its nature, user data is an ideal candidate to carry the load of server provisioning steps like:<br />

1. Installing 3rd party software.<br />
2. Configuring permissions and access.<br />
3. Installing and configuring windows features.<br />
4. Installing endpoint agents, etc.<br />

A few of these steps involve sharing secure credentials as part of authentication. Due to its inability to work with command-line arguments, the user data script requires that these credentials be provided inside the script. That means anyone who has access to the user data script in the EC2 instance also has access to the credentials.<br />
That is not desirable, and there is a way around the problem -AWS System Manager parameter store.

Per AWS-Docs, -Parameter Store (is) a capability of AWS Systems Manager, (that) provides secure, hierarchical storage for configuration data management and secrets management. More information is available at [AWS Systems Manager Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html).<br />

<br />In this Github repo and branch I have a working copy of how to manage secure variables using AWS SSM parameter store using Terraform. I also have supporting documentation on my note at: [Manage sensitive variables in AWS EC2 user data Terraform](https://skundunotes.com/2021/11/17/manage-sensitive-variables-in-aws-ec2-user-data-with-terraform/)
## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />Review the code, especially the `user_data.tpl`, `ssm_parameter.tf`, `iamrole.tf` and `ec2.tf` file to understand all the concepts to (i) store the sensitive credentials in the ssm-parameter store, (ii) associate an IAM role to the EC2 instance that had permission to read from the parameter store, (iii) pass the parameter store variable name to the AWS EC2 user data script to decrypt and (iv) add the capability in the user data script to read from the parameter store.
<br />
<br />Next, run `terraform init`
<br />Then run `terraform plan`
<br />And finally run `terraform apply -var SecureVariableOne=ThisIsASecureValue`