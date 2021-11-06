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
variable "private_ip_address" {
  type    = string
  default = "10.20.20.120"

}
variable "ServerName" {
  type = string
  default = "test-skundu-machine-1"
}