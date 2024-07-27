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
variable "name" {
  description = "The name of the application."
  type        = string
  default     = "app-1"
}
variable "vpc_cidr" {
  description = "CIDR for the VPC."
  default     = "10.20.20.0/25"
  type = string
}
variable "subnet_cidr_private" {
  description = "CIDR blocks for the private subnet."
  default     = "10.20.20.64/26"
  type        = string
}