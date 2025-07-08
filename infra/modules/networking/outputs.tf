output "vpc_self_link" {
  value       = google_compute_network.vpc.self_link
}

output "subnet_self_link" {
  value       = google_compute_subnetwork.subnet.self_link
}
output "pods_range_name" {
  value = google_compute_subnetwork.subnet.secondary_ip_range[0].range_name
}

output "services_range_name" {
  value = google_compute_subnetwork.subnet.secondary_ip_range[1].range_name
}

output "frontend_lb_ip" {
  value = google_compute_address.frontend_lb_ip.address
}