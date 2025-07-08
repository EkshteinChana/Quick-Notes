variable "project_id" {
  type        = string
}

variable "api_services" {
  description = "List of APIs to enable"
  type        = list(string)
}
