resource "aws_secretsmanager_secret" "cidr_block" {
  name = "remote-access-ip"
}

module "server-sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "${var.stage}-${var.app-name}-sg"
  description = "security group for redhat test server, http ports open"
  vpc_id      = data.aws_vpc.dev.id

  # default CIDR block, used for all ingress rules - typically CIDR blocks of the VPC
  ingress_cidr_blocks = [data.aws_vpc.dev.cidr_block]

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = local.ip_secret
    }
  ]
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "redhat-server"

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = "redhat-development"
  monitoring             = true
  vpc_security_group_ids = [module.server-sg.security_group_id]
  subnet_id              = data.aws_subnet.private.id

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for Redhat EC2"
  iam_role_policies = {
    AmazonEC2RoleforSSM = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  tags = {
    Environment = var.stage
  }
}

