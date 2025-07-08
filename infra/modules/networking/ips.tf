resource "google_compute_address" "frontend_lb_ip" {
  name = "${var.app_env}-lb-ip"
  region = var.region
}
