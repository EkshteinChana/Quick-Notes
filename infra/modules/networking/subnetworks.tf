# ==============================================================================
# Module Desc:
# Create VPC and subnets
# ==============================================================================

resource "google_compute_network" "vpc" {
  name                    = "${var.app_env}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name                     = "${var.app_env}-subnet"
  ip_cidr_range            = var.ip_cidr_range
  region                   = var.region
  network                  = google_compute_network.vpc.self_link
  private_ip_google_access = true

  stack_type = "IPV4_IPV6"  # Enables dual-stack

  ipv6_access_type = "EXTERNAL" 

  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = var.pods_ip_cidr_range
  }

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = var.services_ip_cidr_range
  }
}
