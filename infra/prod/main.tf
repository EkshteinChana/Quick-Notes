terraform {
  backend "gcs" {
    bucket  = "quick-notes-prod-tfstate"
    prefix  = "terraform/state"
    }
}


# Enable APIs
module "apis" {
  source     = "../modules/apis"
  project_id = var.project_id
  api_services = [
    "iam.googleapis.com",                  # IAM 
    "cloudresourcemanager.googleapis.com", # Cloud Resource Manager 
    "artifactregistry.googleapis.com",     # Artifact Registry 
    "container.googleapis.com",            # Kubernetes Engine  (GKE)
  ]
}

# Custom service accounts, with the neccessary permissions 
module "iam" {
  source = "../modules/iam"
  project_id = var.project_id
  app_env = var.app_env
  region = var.region
  artifact_registry_repo_name = module.artifact_registry.artifact_registry_repo_name

  depends_on = [module.apis]
}

# Networking 
module "networking" {
  source      = "../modules/networking"
  app_env = var.app_env
  region      = var.region

  depends_on = [module.apis]
}

# Artifact Registry 
module "artifact_registry" {
  source     = "../modules/artifact"
  project_id = var.project_id
  app_env    = var.app_env
  region     = var.region

  depends_on = [module.apis]
}

# Backend Google Kubernetes cluster for node.js app 
module "gke" {
  source              = "../modules/gke"
  project_id          = var.project_id
  region              = var.region
  app_env             = var.app_env
  vpc_self_link       = module.networking.vpc_self_link
  subnet_self_link    = module.networking.subnet_self_link
  pods_range_name     = module.networking.pods_range_name
  services_range_name = module.networking.services_range_name
  gcp_sa_email = module.iam.gke_service_account_email
}

