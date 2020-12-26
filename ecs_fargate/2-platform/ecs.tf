provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {}
}

data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config = {
      region = "${var.region}"
      bucket = "${var.remote_state_bucket}"
      key    = "${var.remote_state_key}"
  }
}

resource "aws_ecs_cluster" "production-fargate-cluster" {
  name = "Production-Fargate-Cluster"
}

resource "aws_elb" "ecs-cluster-elb" {
  name            = "${var.ecs_cluster_name}-ALB"
  internal        = false
  security_groups = [ "${aws_security_group.ecs-alb-security-group.id}" ]
  subnets         = [ "${split(",", join(",", data.terraform_remote_state.infrastructure.public_subnets))}" ]

  tags = {
    "Name" = "${var.ecs_cluster_name}-ALB"
  }
}
