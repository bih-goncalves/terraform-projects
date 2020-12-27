variable "region" {
  default = "us-east-1"
}

variable "remote_state_bucket" {}

variable "remote_state_key" {}

#aplication variables for task
variable "ecs_service_name" {}
variable "docker_image_url" {}
variable "docker_container_port" {}
variable "memory" {}
variable "spring_profile" {}