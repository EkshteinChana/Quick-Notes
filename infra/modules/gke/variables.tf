variable "app_env" {
  description = "name of the environment (e.g., staging, prod)"
}
variable "project_id" {}
variable "vpc_self_link" {}
variable "subnet_self_link" {}
variable "region" {
  description = "The cluster region"
}
variable "pods_range_name" {
  description = "Name of the secondary range for Kubernetes Pods"
}
variable "services_range_name" {
  description = "Name of the secondary range for Kubernetes Services"
}

variable "gcp_sa_email" {
  description = "Email of the GCP service account to bind to the KSA"
}


