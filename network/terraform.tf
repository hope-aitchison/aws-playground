terraform {
  backend "s3" {
    bucket = "terraform-state-redhat-dev"
    key    = "network/terraform.tfstate"
    region = "eu-west-2"

    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}