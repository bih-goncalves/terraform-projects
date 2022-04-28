data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name    = local.product_name
  cidr    = local.cidr
  azs     = data.aws_availability_zones.available.names

  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Application = "VPC"
  }
}
