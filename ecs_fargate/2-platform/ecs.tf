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

resource "aws_alb" "ecs-cluster-alb" {
  name            = "${var.ecs_cluster_name}-ALB"
  internal        = false
  security_groups = [ "${aws_security_group.ecs-alb-security-group.id}" ]
  subnets         = [ "${split(",", join(",", data.terraform_remote_state.infrastructure.public_subnets))}" ]

  tags = {
    "Name" = "${var.ecs_cluster_name}-ALB"
  }
}

resource "aws_alb_listener" "ecs-alb-https-listener" {
  load_balancer_arn = "${aws_alb.ecs-cluster-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = "${aws_acm_certificate.ecs-domain-certificate.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.ecs-default-target-group.arn}"
  }

  depends_on = [ aws_lb_target_group.ecs-default-target-group ]
}

resource "aws_lb_target_group" "ecs-default-target-group" {
  name     = "${var.ecs_cluster_nmae}-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${data.terraform_remote_state.infrastructure.vpc_id}"

  tags = {
    "Name" = "${var.ecs_cluster_name}-TG"
  }
}

resource "aws_route53_record" "ecs-load-balancer-record" {
  name    = "*.${var.ecs_domain_name}"
  type    = "A"
  zone_id = "${data.aws_route53_zone.ecs-domain.zone_id}"

  alias {
    evaluate_target_health = false
    name                   = "${aws_alb.ecs-cluster-alb.dns_name}"
    zone_id                = "${aws_alb.ecs-cluster-alb.zone_id}"
  }
}
