module "server-sg" {
    source = "terraform-aws-modules/security-group/aws/latest"

    name = "${var.stage}-${var.app-name}-sg"
}
