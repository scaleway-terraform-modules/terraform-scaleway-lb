# Name
variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the load balancer"
  type        = list(string)
  default     = []
}

# Resources Management
variable "project_id" {
  description = "Scaleway project ID"
  type        = string
}

# Network
variable "zone" {
  description = "Scaleway zone"
  type        = string
  default     = "fr-par-1"
}

variable "visibility" {
  description = "Visibility of the load balancer: 'internal' or 'internet-facing'"
  type        = string
  default     = "internal"

  validation {
    condition     = contains(["internal", "internet-facing"], var.visibility)
    error_message = "The visibility must be either 'internal' or 'internet-facing'."
  }
}

variable "private_network_id" {
  description = "Private network ID to attach the load balancer to"
  type        = string
}

# Sizing
variable "type" {
  description = "Load balancer type"
  type        = string
  default     = "LB-S"
}

# Backend Management
variable "backend_forward_protocol" {
  description = "Protocol to forward to backend servers"
  type        = string
  default     = "http"
}

variable "backend_forward_port" {
  description = "Port to forward to backend servers"
  type        = number
  default     = 80
}

variable "backend_server_ips" {
  description = "List of backend server IPs"
  type        = list(string)
}

variable "backend_health_check_delay" {
  description = "Delay between health checks"
  type        = string
  default     = "10s"
}

variable "backend_health_check_max_retries" {
  description = "Maximum number of health check retries"
  type        = number
  default     = 2
}

variable "backend_health_check_timeout" {
  description = "Health check timeout"
  type        = string
  default     = "10s"
}

variable "backend_health_check_http_uri" {
  description = "URI for HTTP health check"
  type        = string
  default     = "/"
}

variable "backend_health_check_http_method" {
  description = "HTTP method for health check"
  type        = string
  default     = "GET"
}

variable "backend_health_check_http_code" {
  description = "Expected HTTP status code for health check"
  type        = string
  default     = "200"
}

# Frontend Management
variable "frontend_inbound_port" {
  description = "Inbound port for the frontend (e.g. 443 for HTTPS, 80 for HTTP)"
  type        = number
}

variable "enable_ssl" {
  description = "Whether to enable SSL/TLS with Let's Encrypt certificate (only applies when dns_zone is set)"
  type        = bool
  default     = true
}

# DNS Management
variable "dns_zone" {
  description = "DNS zone for the domain record (optional — no DNS or SSL resources are created if not set)"
  type        = string
  default     = null
}

variable "dns_record_name" {
  description = "Name of the DNS record, without the zone suffix (optional — no DNS resources are created if not set)"
  type        = string
  default     = null
}

variable "dns_record_ttl" {
  description = "TTL for the DNS record"
  type        = number
  default     = 300
}

variable "dns_project_id" {
  description = "Scaleway project ID where the DNS zones and records are managed (required when dns_zone is set)"
  type        = string
  default     = null
}

# SSL Management
variable "ssl_subject_alternative_names" {
  description = "Subject alternative names for the SSL certificate"
  type        = list(string)
  default     = []
}

variable "ignore_ssl_server_verify" {
  description = "Whether the Load Balancer should skip backend server certificate verification"
  type        = bool
  default     = false
}