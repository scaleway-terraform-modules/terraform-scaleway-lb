resource "scaleway_lb_certificate" "this" {
  count = local.enable_ssl ? 1 : 0

  lb_id = scaleway_lb.this.id
  name  = var.name

  letsencrypt {
    common_name              = local.complete_dns_entry
    subject_alternative_name = var.ssl_subject_alternative_names
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [scaleway_domain_record.this]
}