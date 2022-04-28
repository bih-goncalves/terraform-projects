<h2 align="center">DevOps Challenge</h2>

<div align="center">

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> This repository presents the infrastructure configuration for a simple environment using Terraform.
    <br>
</p>

## 📝 Content

- [About](#about)
- [Getting started](#getting_started)
- [Tools](#built_using)
- [Authors](#authors)
- [Acknowledgement](#acknowledgement)
---

## About <a name = "about"></a>

The environment consists of an EC2 in one AWS account and a bucket in other AWS account. The EC2 instance needs to have access to the bucket and its contents.

You can check the infrastructure diagram:

![infrastructure diagram](./images/MetadataDevOps.png?raw=true)

## 🏁 Getting started <a name = "getting_started"></a>


### Prerequisites

```
AWS credentials
Terraform 0.13.5
```

If you don't have AWS credentials configured in your environment, please follow the steps from [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).

This repository uses [tfenv](https://github.com/tfutils/tfenv) to avoid using a terraform version different than the one used to deploy the infrastructure. It will help to prevent bumping the terraform version by mistake. If you have this tool and want to use another version, you can edit the file `.terraform-version`.

### Resources

In account 1, you're going to create:

- VPC
- 3 Public subnets
- 3 Private subnets
- 4 Route tables
- Internet Gateway
- 3 NAT Gateways
- 3 Elastic IPs
- Some seccurity groups
- EC2 instance
- Private SSH key
- IAM role for EC2
- IAM policy for EC2
- IAM instance profile for EC2

In account 2, you're going to create:

- S3 Bucket

### Terraform

First of all, go to the folder `terraform_code`, fill the AWS profiles' information and the TF state config in `provider.tf` file. Now you can initialize the backend:

```
terraform init
```

After initialized, you can check the plan of resources to be created:

```
terraform plan -out=plano
```

Check the plan of resources to be created and if you're happy with that, apply it:

```
terraform apply plano
```

If you want to change some configurations, you can edit the `settings.tf` file. Then, go back to the plan step.

You can compare the plan output with the one in `PLANO.md` from repo's root folder.

## ⛏️ Tools <a name = "built_using"></a>

- [AWS](https://aws.amazon.com/) - Cloud service
- [Terraform](https://www.terraform.io/) - Open-source infrastructure as code software tool that enables you to safely and predictably create, change, and improve infrastructure.
- [tfenv](https://github.com/tfutils/tfenv) - Terraform version manager.

## ✍️ Authors <a name = "authors"></a>

- [@bih-goncalves](https://github.com/bih-goncalves)

## 🎉 Acknowledgement <a name = "acknowledgement"></a>

- This project is a challenge for DevOps role at [@Metadata](https://metadata.io)

You can check other Terraform projects from [this repo](https://github.com/bih-goncalves/terraform-projects/tree/main) :)
