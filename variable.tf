variable "access_key" {
  type      = string
  default   = ""
  sensitive = true
}
variable "secret_key" {
  type      = string
  default   = ""
  sensitive = true
}
variable "region" {
  type    = string
  default = "us-east-2"
}
variable "ServerName" {
  type    = string
  default = "app-1-server-1"
}
variable "SecureVariableOne" {
  type      = string
  default   = ""
  sensitive = true
}
variable "s3_bucket_name" {
  type      = string
  description = "The S3 bucket name to store the files from the file folder in this repository. "
  default   = "your-s3-bucket-name"
}