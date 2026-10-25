# terraform-scaleway-lb

Terraform module to manage [Scaleway Load Balancers](https://www.scaleway.com/en/load-balancer/).

## Features

- Deploy an internal or internet-facing Load Balancer on a private network
- Configurable backend with HTTP health checks
- Optional DNS record creation for the load balancer IP
- Optional Let's Encrypt SSL certificate (requires DNS)

## Usage

### Internal load balancer

```hcl
module "lb" {
  source  = "scaleway-terraform-modules/lb/scaleway"
  version = "~> 0.0"

  name       = "my-service"
  project_id = var.project_id

  visibility         = "internal"
  private_network_id = scaleway_vpc_private_network.main.id

  backend_forward_port          = 8080
  backend_server_ips            = ["10.0.0.1"]
  backend_health_check_http_uri = "/health"

  frontend_inbound_port = 8080
}
```

### Internet-facing load balancer with DNS and SSL

```hcl
module "lb" {
  source  = "scaleway-terraform-modules/lb/scaleway"
  version = "~> 0.0"

  name       = "my-api"
  project_id = var.project_id

  visibility         = "internet-facing"
  private_network_id = scaleway_vpc_private_network.main.id

  backend_forward_port = 80
  backend_server_ips   = ["10.0.0.1"]

  frontend_inbound_port = 443

  dns_zone        = "example.com"
  dns_record_name = "api"
  dns_project_id  = var.dns_project_id
}
```

## Examples

- [Internal](./examples/internal) — internal load balancer on a private network
- [Internet-facing](./examples/internet-facing) — public load balancer with DNS and SSL

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.13 |
| <a name="requirement_scaleway"></a> [scaleway](#requirement_scaleway) | >= 2.60.4 |

## Resources

| Name | Type |
|------|------|
| [scaleway_domain_record.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/domain_record) | resource |
| [scaleway_lb.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb) | resource |
| [scaleway_lb_backend.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_backend) | resource |
| [scaleway_lb_certificate.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_certificate) | resource |
| [scaleway_lb_frontend.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_frontend) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_server_ips"></a> [backend_server_ips](#input_backend_server_ips) | List of backend server IPs | `list(string)` | n/a | yes |
| <a name="input_frontend_inbound_port"></a> [frontend_inbound_port](#input_frontend_inbound_port) | Inbound port for the frontend (e.g. 443 for HTTPS, 80 for HTTP) | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | Name of the load balancer | `string` | n/a | yes |
| <a name="input_private_network_id"></a> [private_network_id](#input_private_network_id) | Private network ID to attach the load balancer to | `string` | n/a | yes |
| <a name="input_project_id"></a> [project_id](#input_project_id) | Scaleway project ID | `string` | n/a | yes |
| <a name="input_backend_forward_port"></a> [backend_forward_port](#input_backend_forward_port) | Port to forward to backend servers | `number` | `80` | no |
| <a name="input_backend_forward_protocol"></a> [backend_forward_protocol](#input_backend_forward_protocol) | Protocol to forward to backend servers | `string` | `"http"` | no |
| <a name="input_backend_health_check_delay"></a> [backend_health_check_delay](#input_backend_health_check_delay) | Delay between health checks | `string` | `"10s"` | no |
| <a name="input_backend_health_check_http_code"></a> [backend_health_check_http_code](#input_backend_health_check_http_code) | Expected HTTP status code for health check | `string` | `"200"` | no |
| <a name="input_backend_health_check_http_method"></a> [backend_health_check_http_method](#input_backend_health_check_http_method) | HTTP method for health check | `string` | `"GET"` | no |
| <a name="input_backend_health_check_http_uri"></a> [backend_health_check_http_uri](#input_backend_health_check_http_uri) | URI for HTTP health check | `string` | `"/"` | no |
| <a name="input_backend_health_check_max_retries"></a> [backend_health_check_max_retries](#input_backend_health_check_max_retries) | Maximum number of health check retries | `number` | `2` | no |
| <a name="input_backend_health_check_timeout"></a> [backend_health_check_timeout](#input_backend_health_check_timeout) | Health check timeout | `string` | `"10s"` | no |
| <a name="input_dns_project_id"></a> [dns_project_id](#input_dns_project_id) | Scaleway project ID where the DNS zones and records are managed (required when dns_zone is set) | `string` | `null` | no |
| <a name="input_dns_record_name"></a> [dns_record_name](#input_dns_record_name) | Name of the DNS record, without the zone suffix (optional — no DNS resources are created if not set) | `string` | `null` | no |
| <a name="input_dns_record_ttl"></a> [dns_record_ttl](#input_dns_record_ttl) | TTL for the DNS record | `number` | `300` | no |
| <a name="input_dns_zone"></a> [dns_zone](#input_dns_zone) | DNS zone for the domain record (optional — no DNS or SSL resources are created if not set) | `string` | `null` | no |
| <a name="input_enable_ssl"></a> [enable_ssl](#input_enable_ssl) | Whether to enable SSL/TLS with Let's Encrypt certificate (only applies when dns_zone is set) | `bool` | `true` | no |
| <a name="input_ignore_ssl_server_verify"></a> [ignore_ssl_server_verify](#input_ignore_ssl_server_verify) | Whether the Load Balancer should skip backend server certificate verification | `bool` | `false` | no |
| <a name="input_ssl_subject_alternative_names"></a> [ssl_subject_alternative_names](#input_ssl_subject_alternative_names) | Subject alternative names for the SSL certificate | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input_tags) | Tags to apply to the load balancer | `list(string)` | `[]` | no |
| <a name="input_type"></a> [type](#input_type) | Load balancer type | `string` | `"LB-S"` | no |
| <a name="input_visibility"></a> [visibility](#input_visibility) | Visibility of the load balancer: 'internal' or 'internet-facing' | `string` | `"internal"` | no |
| <a name="input_zone"></a> [zone](#input_zone) | Scaleway zone | `string` | `"fr-par-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_id"></a> [backend_id](#output_backend_id) | ID of the backend |
| <a name="output_certificate_id"></a> [certificate_id](#output_certificate_id) | ID of the SSL certificate (only set when SSL is enabled) |
| <a name="output_dns_record_fqdn"></a> [dns_record_fqdn](#output_dns_record_fqdn) | Fully qualified domain name of the DNS record (only set when DNS is configured) |
| <a name="output_frontend_id"></a> [frontend_id](#output_frontend_id) | ID of the frontend |
| <a name="output_lb_id"></a> [lb_id](#output_lb_id) | ID of the load balancer |
| <a name="output_lb_ip_address"></a> [lb_ip_address](#output_lb_ip_address) | Public IP address of the load balancer (null for internal LB) |
| <a name="output_lb_private_ip_address"></a> [lb_private_ip_address](#output_lb_private_ip_address) | Private IP address of the load balancer |
<!-- END_TF_DOCS -->

## Authors

Module is maintained with help from [the community](https://github.com/scaleway-terraform-modules/terraform-scaleway-lb/graphs/contributors).

## License

Mozilla Public License 2.0 Licensed. See [LICENSE](https://github.com/scaleway-terraform-modules/terraform-scaleway-lb/tree/master/LICENSE) for full details.