data "google_client_config" "default" {}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.19.0"
    }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = "2.17.0"
    # }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
  }
}

provider "google" {
  credentials = file("./sa-key.json")
  project     = var.project_id
  region      = var.region
}

provider "kubernetes" {
  host                   = module.gke.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

# provider "helm" {
#   kubernetes {
#     host                   = module.gke.endpoint
#     token                  = data.google_client_config.default.access_token
#     # cluster_ca_certificate = base64decode(module.gke.ca_certificate)
#     config_path = "C:/Users/User/.kube/config"
#   }
# }
