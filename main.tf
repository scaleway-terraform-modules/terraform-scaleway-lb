resource "scaleway_lb" "this" {
  zone               = var.zone
  type               = var.type
  name               = local.name
  project_id         = var.project_id
  tags               = var.tags
  assign_flexible_ip = var.visibility == "internet-facing"

  private_network {
    private_network_id = var.private_network_id
  }
}

resource "scaleway_lb_backend" "this" {
  lb_id = scaleway_lb.this.id
  name  = local.backend_name

  forward_protocol = var.backend_forward_protocol
  forward_port     = var.backend_forward_port

  health_check_delay       = var.backend_health_check_delay
  health_check_max_retries = var.backend_health_check_max_retries
  health_check_timeout     = var.backend_health_check_timeout
  ignore_ssl_server_verify = var.ignore_ssl_server_verify

  server_ips = var.backend_server_ips

  timeout_queue = "0s"

  health_check_http {
    code   = var.backend_health_check_http_code
    method = var.backend_health_check_http_method
    uri    = var.backend_health_check_http_uri
  }
}

resource "scaleway_lb_frontend" "this" {
  lb_id = scaleway_lb.this.id
  name  = local.frontend_name

  backend_id      = scaleway_lb_backend.this.id
  inbound_port    = var.frontend_inbound_port
  certificate_ids = local.enable_ssl ? [scaleway_lb_certificate.this[0].id] : []
}