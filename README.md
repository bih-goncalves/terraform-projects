# Terraform Projects

## ECS Fargate with TF
This project is a Fargate cluster built for AWS using Terraform as Infra as Code.

The project has 3 layers of information. The first is the layer where all infrastructure is defined (VPC, networks, security, etc). The second layer is where we define the platform, we work with the cluster, the domain, etc. The third layer is about the aplication, where we define the task definition, fargate aplication and everything related with an app.

## GKE environment
This project is for a GKE cluster providing the essential stuff like networking, machines and roles. As a bonus, there is the GCR config for application image.

## ✍️ Author <a name = "authors"></a>

- [@bih-goncalves](https://github.com/bih-goncalves)