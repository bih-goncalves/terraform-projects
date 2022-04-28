provider "aws" {
  region  = "us-east-1"

  default_tags {
    tags = {
      Product     = local.product_name
      Environment = title(local.env)
      Monitoring  = "CloudWatch"
      TechContact = "DevOps"
      Deprecate   = "N"
    }
  }
}

terraform {
  required_version = ">= 1.1.9"


}

