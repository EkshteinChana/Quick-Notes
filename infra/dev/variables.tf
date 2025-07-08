# Generic
variable "project_id" {
  description = "GCP project ID"
}
variable "region" {
  description = "Region where resources will be deployed"
  default     = "me-west1"
}
variable "app_env" {
  description = "the appp name and the depolyment env (e.g. Quick-notes-prod)"
}


# GKE
variable "ksa_namespace" {}

