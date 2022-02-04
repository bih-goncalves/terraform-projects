output "kubernetes_cluster_name" {
  value       = google_container_cluster.fibonacci_cluster.id
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.fibonacci_cluster.endpoint
  description = "GKE Cluster Host"
}
