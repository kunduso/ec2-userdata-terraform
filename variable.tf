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
  type      = string
  default   = "us-east-2"
}