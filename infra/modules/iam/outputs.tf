output "gke_service_account_email" {
  value = google_service_account.gke_sa.email
}

output "ksa_name" {
  value       = "${var.app_env}-ksa"
  description = "Kubernetes Service Account name"
}