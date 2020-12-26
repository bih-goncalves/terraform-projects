<h3 align="center">ECS Fargate with TF</h3>

## 📝 Content

- [About](#about)
- [Infrastructure](#infrastructure)
- [Platform](#platform)
- [Aplication](#aplication)
- [Extras](#extras)
- [Author](#authors)


## About the Project <a name = "about"></a>

This project is a Fargate cluster built for AWS using Terraform as Infra as Code.

The project has 3 layers of information. The first is the layer where all infrastructure is defined (VPC, networks, security, etc). The second layer is where we define the platform, we work with the cluster, the domain, etc. The third layer is about the aplication, where we define the task definition, fargate aplication and everything related with an app.

```
Resources 

- 1 VPC
- 6 subnets with 254 usable hosts for each
  - 3 public subnets - 10.0.1.0/24 in AZ 1, 10.0.2.0/24 in AZ 2 and 10.0.3.0/24 in AZ 3
  - 3 private subnets - 10.0.4.0/24 in AZ 1, 10.0.5.0/24 in AZ 2 and 10.0.6.0/24 in AZ 3
- 2 route tables - 1 public and 1 private
- 1 internal gateway
- 1 NAT gateway
- 1 ECS cluster
- Fargate ECS service
- 1 ECR repository
```


## Infrastructure <a name = "infrastructure"></a>


## Platform <a name = "platform"></a>


## Aplication <a name = "aplication"></a>


## Extras <a name = "extras"></a>


## ✍️ Author <a name = "authors"></a>

- [@bih-goncalves](https://github.com/bih-goncalves)