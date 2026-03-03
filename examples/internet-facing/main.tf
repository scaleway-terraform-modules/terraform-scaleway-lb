resource "scaleway_vpc_private_network" "main" {
  name = "my-private-network"
}

module "lb" {
  source = "../.."

  name       = "my-api"
  project_id = var.project_id

  zone               = "fr-par-1"
  visibility         = "internet-facing"
  private_network_id = scaleway_vpc_private_network.main.id

  type = "LB-S"

  backend_forward_protocol = "http"
  backend_forward_port     = 80
  backend_server_ips       = ["10.0.0.1"]

  frontend_inbound_port = 443

  dns_zone        = "example.com"
  dns_record_name = "api"
  dns_project_id  = var.dns_project_id

  tags = ["env:prod"]
}

output "lb_ip" {
  description = "Public IP address of the load balancer"
  value       = module.lb.lb_ip_address
}

output "fqdn" {
  description = "Fully qualified domain name"
  value       = module.lb.dns_record_fqdn
}