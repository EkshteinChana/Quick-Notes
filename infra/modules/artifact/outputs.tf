output "artifact_registry_repo_name" {
  value = google_artifact_registry_repository.docker_repo.name
}

output "repo_url" {
  value = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.docker_repo.name}"
}