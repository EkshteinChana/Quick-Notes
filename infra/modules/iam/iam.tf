# ==============================================================================
# Module Desc:
# Custom service accounts, with the neccessary permissions 
# ==============================================================================

# GKE Service Account
resource "google_service_account" "gke_sa" {
  account_id   = "${var.app_env}-gke-sa"
  display_name = "GKE Node Service Account"
  project      = var.project_id
}

# Grant Artifact Registry read access
resource "google_artifact_registry_repository_iam_member" "gke_artifact_access" {
  project    = var.project_id
  location   = var.region  
  repository = var.artifact_registry_repo_name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.gke_sa.email}"
}

# Bind KSA to impersonate the GCP SA via Workload Identity
resource "google_service_account_iam_member" "workload_identity_binding" {
  service_account_id = google_service_account.gke_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.app_env}/${var.app_env}-ksa]"
}

