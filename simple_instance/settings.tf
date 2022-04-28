locals {
  env = "sandbox"

  product_name = "bianca-test"
  bucket_name  = "bianca-sandbox"

  # Networking settings when using a fresh VPC
  # https://en.wikipedia.org/wiki/Private_network#Private_IPv4_addresses
  cidr            = "172.66.0.0/16"
  private_subnets = ["172.66.32.0/19", "172.66.64.0/19", "172.66.96.0/19"]
  public_subnets  = ["172.66.128.0/19", "172.66.160.0/19", "172.66.192.0/19"]

  # EC2
  image_ami     = "ami-0a8b4cd432b1c3063" # amazon linux 64 bit in us-east-1
  instance_type = "t2.micro"
  volume_size   = 30
}