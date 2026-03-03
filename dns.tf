resource "scaleway_domain_record" "this" {
  count = local.has_dns ? 1 : 0

  project_id = var.dns_project_id
  dns_zone   = var.dns_zone
  name       = var.dns_record_name
  type       = "A"
  data       = var.visibility == "internet-facing" ? scaleway_lb.this.ip_address : scaleway_lb.this.private_ips[0].address
  ttl        = var.dns_record_ttl
}