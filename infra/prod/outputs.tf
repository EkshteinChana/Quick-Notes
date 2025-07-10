output "frontend_lb_ip" {
  value = module.networking.frontend_lb_ip
}

output "gke_service_account_email" {
  value = module.iam.gke_service_account_email
}

output "repo_url" {
  value = module.artifact_registry.repo_url
}

output "ksa_name" {
  value = module.iam.ksa_name
}
