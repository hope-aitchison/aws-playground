// module "vpc" {
//   source = "terraform-aws-modules/vpc/aws"

//   name               = "${var.stage}-vpc"
//   cidr               = "10.0.0.0/16"
//   azs                = ["${var.region}a", "${var.region}b"]
//   public_subnets     = ["10.0.101.0/24"]

//   tags = {
//     Terraform = "true"
//     Stage     = var.stage
//     Account   = data.aws_caller_identity.current.account_id
//     App-name  = var.app-name
//   }
// }

