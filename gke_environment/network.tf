# VPC
resource "google_compute_network" "vpc" {
  name                    = "${local.product_name}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnetwork_us_east1" {
  name          = "${local.product_name}-us-east1"
  ip_cidr_range = "10.1.0.0/16"
  network       = google_compute_network.vpc.self_link
  region        = "us-east1"

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.16.0.0/14"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.24.16.0/20"
  }
}
