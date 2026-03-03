resource "scaleway_vpc_private_network" "main" {
  name = "my-private-network"
}

module "lb" {
  source = "../.."

  name       = "my-service"
  project_id = var.project_id

  zone               = "fr-par-1"
  visibility         = "internal"
  private_network_id = scaleway_vpc_private_network.main.id

  type = "LB-S"

  backend_forward_protocol      = "http"
  backend_forward_port          = 8080
  backend_server_ips            = ["10.0.0.1"]
  backend_health_check_http_uri = "/health"

  frontend_inbound_port = 8080

  tags = ["env:dev"]
}

output "lb_private_ip" {
  description = "Private IP address of the load balancer"
  value       = module.lb.lb_private_ip_address
}