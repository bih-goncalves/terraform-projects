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