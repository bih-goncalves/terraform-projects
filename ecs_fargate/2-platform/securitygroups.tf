resource "aws_security_group" "ecs-alb-security-group" {
  name        = "${var.ecs_cluster_name}-ALB-SG"
  description = "Security Group for ALB to traffic for ECS cluster"
  vpc_id      = "${data.terraform_remote_state.infrastructure.vpc_id}"

  ingress = [ {
    cidr_blocks = [ "${var.internet_cidr_blocks}" ]
    description = "Traffic from internet"
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
  } ]

  egress = [ {
    cidr_blocks = [ "${var.internet_cidr_blocks}" ]
    description = "Traffic from ALB to internet"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  } ]
}