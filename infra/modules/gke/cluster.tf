# ==============================================================================
# Module Desc:
# Create Kubernetes cluster for all the app services
# ==============================================================================

resource "google_container_cluster" "primary" {
  name     = "${var.app_env}-gke-cluster"
  location = var.region

  enable_autopilot = true
  deletion_protection = false

  network    = var.vpc_self_link
  subnetwork = var.subnet_self_link

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
    stack_type = "IPV4_IPV6"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  release_channel {
    channel = "REGULAR"
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  # lifecycle {
  #     prevent_destroy = true
  #     ignore_changes = [
  #       tpu_ipv4_cidr_block,
  #       private_ipv6_google_access,
  #       operation
  #     ]
  # }


}

# resource "kubernetes_service_account" "app_ksa" {
#   metadata {
#     name      = "${var.app_env}-ksa"
#     namespace = kubernetes_namespace.app.metadata[0].name
#     annotations = {
#       "iam.gke.io/gcp-service-account" = var.gcp_sa_email
#     }
#   }
# }