data "aws_caller_identity" "current" {}
# runs aws sts get-caller-identity --profile {NAME}

data "aws_vpc" "dev" {
  tags = {
    Terraform = "true"
    Stage     = var.stage
    Account   = data.aws_caller_identity.current.account_id
  }
}

data "aws_subnet" "private" {
  vpc_id = data.aws_vpc.dev.id
  filter {
    name   = "tag:Name"
    values = ["dev-vpc-private-eu-west-2a"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}