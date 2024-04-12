module "server-sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "${var.stage}-${var.app-name}-sg"
  description = "security group for redhat test server, http ports open"
  vpc_id      = data.aws_vpc.dev.id

  ingress_cidr_blocks = ["10.10.0.0/16"]
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

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  tags = {
    Environment = var.stage
  }
}