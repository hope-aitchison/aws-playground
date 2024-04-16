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
    values = ["RHEL_HA-9.3.0_*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_secretsmanager_secret" "remote_ip" {
  name = "remote-access-ip"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.remote_ip.id
}
