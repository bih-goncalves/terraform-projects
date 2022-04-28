resource "tls_private_key" "bianca_test" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bianca_test" {
  key_name   = "bianca_test_${local.env}"
  public_key = tls_private_key.bianca_test.public_key_openssh

  tags = {
    Application = "SSH Key Pair"
  }
}

resource "aws_instance" "bianca_test" {
  ami           = local.image_ami
  instance_type = local.instance_type

  subnet_id              = module.vpc.private_subnets[0]
  key_name               = aws_key_pair.bianca_test.key_name
  vpc_security_group_ids = [module.bianca_test_sg.security_group_id]
  iam_instance_profile   = aws_iam_instance_profile.bianca_test_profile.id

  root_block_device {
    delete_on_termination = true
    volume_size           = local.volume_size

    tags = {
      Application = "Root Block"
    }
  }

  tags = {
    Name        = "${local.product_name}-${local.env}"
    Application = "EC2 Instance"
  }
}

module "bianca_test_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.3.0"

  name        = "${local.product_name}-sg"
  description = "Security group for EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [local.cidr]
  ingress_rules       = ["rdp-tcp", "rdp-udp", "ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = {
    Application = "Security Group"
  }
}
