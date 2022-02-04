locals {
  project_id  = ""
  region      = "us-east1"
  environment = "dev"

  product_name = "fibonacci-calculator"
  node_version = "1.21.3-gke.2001"
  machine_type = "n1-standard-1"
  asg_min      = 1
  asg_max      = 3
}