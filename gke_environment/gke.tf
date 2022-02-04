resource "google_container_cluster" "fibonacci_cluster" {
  name     = local.product_name
  location = "us-east1-c"

  lifecycle {
    ignore_changes = [
      node_pool,
      network,
      subnetwork,
    ]
  }

  node_pool {
    name = "default-pool"
  }

  network    = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.subnetwork_us_east1.self_link

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  resource_labels = {
    product     = local.product_name
    application = "kubernetes_cluster"
    environment = local.environment
  }

  node_version = local.node_version
}

resource "google_container_node_pool" "np" {
  location           = "us-east1-c"
  cluster            = google_container_cluster.fibonacci_cluster.name
  version            = local.node_version
  initial_node_count = local.asg_min

  autoscaling {
    min_node_count = local.asg_min
    max_node_count = local.asg_max
  }

  node_config {
    machine_type = local.machine_type

    oauth_scopes = [
      "compute-rw",
      "storage-ro",
      "logging-write",
      "monitoring",
    ]

    labels = {
      product     = local.product_name
      application = "kubernetes_cluster"
      environment = local.environment
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
