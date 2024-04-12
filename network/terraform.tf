terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-state-redhat-dev"
    key            = "network/terraform.tfstate"
    region         = "eu-west-2"

    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}