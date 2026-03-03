locals {
  suffix        = var.visibility == "internal" ? "int-lb" : "lb"
  name          = "${lower(var.name)}-${local.suffix}"
  backend_name  = "backend-${lower(var.name)}"
  frontend_name = "frontend-${lower(var.name)}"

  has_dns            = var.dns_zone != null && var.dns_record_name != null
  complete_dns_entry = local.has_dns ? (var.dns_record_name != "" ? "${var.dns_record_name}.${var.dns_zone}" : var.dns_zone) : null
  enable_ssl         = local.has_dns ? (var.visibility == "internet-facing" ? true : var.enable_ssl) : false
}