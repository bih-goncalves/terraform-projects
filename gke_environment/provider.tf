provider "google" {
  project = local.project_id
  region  = local.region
}

provider "google-beta" {
  project = local.project_id
  region  = local.region
}

terraform {
  required_version = ">= 0.12.31"

  required_providers {
    google      = "~> 3.83"
    google-beta = "~> 3.83"
  }
}
