// resource "aws_secretsmanager_secret" "cidr_block" {
//   name = "remote-access-ip"
// }

module "server-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.stage}-${var.app-name}-sg"
  description = "security group for red hat revision server"
  vpc_id      = data.aws_vpc.dev.id

  # default CIDR block, used for all ingress rules - typically CIDR blocks of the VPC
//   ingress_cidr_blocks = [data.aws_vpc.dev.cidr_block]
//   ingress_with_cidr_blocks = [
//     {
//       rule        = "rdp-tcp"
//       cidr_blocks = local.ip_secret
//     },
//     {
//       rule        = "rdp-udp"
//       cidr_blocks = local.ip_secret
//     },
//     {
//       rule        = "https-443-tcp"
//       cidr_blocks = local.ip_secret
//     },
//   ]

//   egress_cidr_blocks = [data.aws_vpc.dev.cidr_block]
  egress_rules       = ["https-443-tcp", "http-80-tcp"]
//   egress_rules       = ["http-80-tcp"]
//   egress_with_cidr_blocks = [
//     {
//       rule        = "https-443-tcp"
//       cidr_blocks = var.internet_cidr
//     },
//     {
//       rule        = "http-80-tcp"
//       cidr_blocks = var.internet_cidr
//     },
//     {
//       rule        = "rdp-tcp"
//       cidr_blocks = local.ip_secret
//     },
//     {
//       rule        = "rdp-udp"
//       cidr_blocks = local.ip_secret
//     },
//   ]
}

module "ec2_instance_rhel_public" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "rhel-9-server"

  ami                    = "ami-035cecbff25e0d91e" # free tier RHEL9
  instance_type          = "t3.micro" 
//   key_name               = var.key-pair
  monitoring             = true
  vpc_security_group_ids = [module.server-sg.security_group_id]
  subnet_id              = data.aws_subnet.public.id
  associate_public_ip_address = true

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for Redhat EC2"
  iam_role_policies = {
    AmazonEC2RoleforSSM = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  user_data_base64            = filebase64("user_data.sh")
  user_data_replace_on_change = true

  root_block_device = [
    {
      volume_type = "gp3"
      throughput  = 200
      volume_size = 20
      volume_tags = {
        Name = "root"
      }
    },
  ]

  tags = {
    Environment = var.stage
  }
}