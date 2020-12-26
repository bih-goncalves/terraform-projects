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

In this section we defined the VPC, the subnets (3 public and 3 private), the route tables (1 public and 1 private), the internet gateway, the nat gateway and the association between elements.

To work with this module toy have to initialize terraform completing the `infrastructure-prod.config` file with the bucket information.

```
terraform init -backend-config="infrastructure-prod.config"
```

Then you define the values for your infrastructure with the `production.tfvars` file. Use `terraform plan` to see what resources will be created.

```
terraform plan -var-file="production.tfvars" 

# a lot of output and this in the end
Plan: 20 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + private_subnet_1_id = (known after apply)
  + private_subnet_2_id = (known after apply)
  + private_subnet_3_id = (known after apply)
  + public_subnet_1_id  = (known after apply)
  + public_subnet_2_id  = (known after apply)
  + public_subnet_3_id  = (known after apply)
  + vpc_cidr_block      = "10.0.0.0/16"
  + vpc_id              = (known after apply)
```

Pay attention to the outputs that we are asking terraform. If you want more, feel free to add it in `outputs.tf` file.

For the last step, you will apply all changes to create the resources.

```
terraform apply -var-file="production.tfvars" 
```
And you will get real values from the resources created.

## Platform <a name = "platform"></a>


## Aplication <a name = "aplication"></a>


## Extras <a name = "extras"></a>


## ✍️ Author <a name = "authors"></a>

- [@bih-goncalves](https://github.com/bih-goncalves)