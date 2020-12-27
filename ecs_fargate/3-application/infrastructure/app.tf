provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {}
}

data "terraform_remote_state" "platform" {
  backend = "s3"

  config = {
      region = "${var.region}"
      bucket = "${var.remote_state_bucket}"
      key    = "${var.remote_state_key}"
  }
}

data "template_file" "ecs-task-definition-template" {
  template = "${file(task_definition.json)}"

  vars = {
    "task_definition_name"  = "${var.ecs_service_name}"
    "ecs_service_name"      = "${var.ecs_service_name}"
    "docker_image_url"      = "${var.docker_image_url}"
    "docker_container_port" = "${var.docker_container_port}"
    "memory"                = "${var.memory}"
    "spring_profile"        = "${var.spring_profile}"
    "region"                = "${var.region}"
  }
}

resource "aws_ecs_task_definition" "springbootapp-task-definition" {
  container_definitions    = "${data.template_file.ecs-task-definition-template.rendered}"
  family                   = "${var.ecs_service_name}"
  cpu                      = 512
  memory                   = "${var.memory}"
  requires_compatibilities = [ "FARGATE" ]
  network_mode             = "awsvpc"
  execution_role_arn       = ""
  task_role_arn            = ""
}

resource "aws_iam_role" "fargate-iam-role" {
  name               = "${var.ecs_service_name}-IAM-Role"
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
        },
        "Action": "sts:AssumeRole"
    }
    ]
}
EOF
}

resource "aws_iam_role_policy" "fargate-iam-role-policy" {
  name = "${var.ecs_service_name}-IAM-Role-Policy"
  role = "${aws_iam_role.fargate-iam-role.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:*",
                "ecr:*",
                "logs:*",
                "cloudwatch:*",
                "elasticloadbalancing:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_security_group" "app-security-group" {
  name = "${var.ecs_service_name}-SG"
  description = "Security group for springbootapp to comunicate in and out"
  vpc_id = "${data.terraform_remote_state.platform.outputs.vpc_id}"

  ingress = [ {
    cidr_blocks = [ "${data.terraform_remote_state.platform.outputs.vpc_cidr_blocks}" ]
    description = "inboud for aplication"
    from_port   = 8080
    protocol    = "TCP"
    to_port     = 8080
  } ]

  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "outbound for aplication"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  } ]

  tags = {
    "Name" = "${var.ecs_service_name}-SG"
  }
}

resource "aws_alb_target_group" "ecs-app-target-group" {
  name        = "${var.ecs_service_name}-TG"
  port        = "${var.docker_container_port}"
  protocol    = "HTTP"
  vpc_id      = "${data.terraform_remote_state.platform.outputs.vpc_id}"
  target_type = "ip"

  health_check {
    path                = "/actuator/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 60
    timeout             = 30
    unhealthy_threshold = "3"
    healthy_threshold   = "3"
  }

  tags = {
    "Name" = "${var.ecs_service_name}-TG"
  }
}