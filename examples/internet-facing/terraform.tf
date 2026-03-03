terraform {
  required_version = ">= 1.13"

  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = ">= 2.60.4"
    }
  }
}

variable "project_id" {
  description = "Scaleway project ID"
  type        = string
}

variable "dns_project_id" {
  description = "Scaleway project ID for DNS management"
  type        = string
}