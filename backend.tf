terraform {
  backend "s3" {
    bucket         = "skundu-tg-rs-poc"
    encrypt        = true
    key            = "tf/project-31/terraform.tfstate"
    region         = "us-east-2"
  }
}