# ==============================================================================
# Module Desc:
# Create artifact repo for docker imgs
# ==============================================================================

resource "google_artifact_registry_repository" "docker_repo" {
  project       = var.project_id
  location      = var.region
  repository_id = "${var.app_env}-repo"
  format        = "DOCKER"
  description   = "Docker repository for the app images"
}

