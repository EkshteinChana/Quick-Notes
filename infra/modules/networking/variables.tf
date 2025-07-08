variable "app_env" {}
variable "region" {
  default     = "me-west1"
}
variable "ip_cidr_range" {
  description = "The IP range for the subnet"
  default     = "10.0.1.0/24"
}
variable "pods_ip_cidr_range" {
  default = "10.20.0.0/16"
}  
variable "services_ip_cidr_range" {
  default = "10.2.0.0/20"
}  
