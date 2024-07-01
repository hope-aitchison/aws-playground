module "server-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.stage}-${var.app-name}-sg"
  description = "security group for red hat revision server"
  vpc_id      = data.aws_vpc.dev.id

  # default CIDR block, used for all ingress rules - typically CIDR blocks of the VPC
  ingress_cidr_blocks = [data.aws_vpc.dev.cidr_block]

  // egress_cidr_blocks = [data.aws_vpc.dev.cidr_block]
  egress_cidr_blocks = [var.internet_cidr]
  egress_rules       = ["https-443-tcp", "http-80-tcp"]
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

resource "aws_ebs_volume" "sdf" {
    availability_zone = "eu-west-2a"
    size              = 10

    tags = {
        Environment = var.stage
    }
}

resource "aws_volume_attachment" "sdf_att" {
    device_name = "/dev/sdf"
    volume_id   = aws_ebs_volume.sdf.id
    instance_id = module.ec2_instance_rhel_public.id
}