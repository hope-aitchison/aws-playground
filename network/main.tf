module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "${var.stage}-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["${var.region}a", "${var.region}b"]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]     # 2 for High-Availability
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"] # 2 for High-Availability
  enable_nat_gateway = true

  tags = {
    Terraform        = "true"
    Stage            = var.stage
    Account          = data.aws_caller_identity.current.account_id
    App-name         = var.app-name
  }
}