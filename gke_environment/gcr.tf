resource "google_container_registry" "registry" {
  project  = local.project_id
  location = "US"
}
