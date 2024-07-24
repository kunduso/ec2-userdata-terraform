#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "auth" {
  length           = 32
  special          = true
  override_special = "!&#$"
}