output "lb_id" {
  description = "ID of the load balancer"
  value       = scaleway_lb.this.id
}

output "lb_ip_address" {
  description = "Public IP address of the load balancer (null for internal LB)"
  value       = scaleway_lb.this.ip_address
}

output "lb_private_ip_address" {
  description = "Private IP address of the load balancer"
  value       = scaleway_lb.this.private_ips[0].address
}

output "backend_id" {
  description = "ID of the backend"
  value       = scaleway_lb_backend.this.id
}

output "frontend_id" {
  description = "ID of the frontend"
  value       = scaleway_lb_frontend.this.id
}

output "dns_record_fqdn" {
  description = "Fully qualified domain name of the DNS record (only set when DNS is configured)"
  value       = local.has_dns ? (scaleway_domain_record.this[0].name == "" ? var.dns_zone : "${scaleway_domain_record.this[0].name}.${var.dns_zone}") : null
}

output "certificate_id" {
  description = "ID of the SSL certificate (only set when SSL is enabled)"
  value       = local.enable_ssl ? scaleway_lb_certificate.this[0].id : null
}