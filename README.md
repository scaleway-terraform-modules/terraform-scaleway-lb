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
  source  = "scaleway/lb/scaleway"
  version = ">= 1.0.0"

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
  source  = "scaleway/lb/scaleway"
  version = ">= 1.0.0"

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.13 |
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | >= 2.60.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | >= 2.60.4 |

## Modules

No modules.

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
| <a name="input_backend_forward_port"></a> [backend\_forward\_port](#input\_backend\_forward\_port) | Port to forward to backend servers | `number` | `80` | no |
| <a name="input_backend_forward_protocol"></a> [backend\_forward\_protocol](#input\_backend\_forward\_protocol) | Protocol to forward to backend servers | `string` | `"http"` | no |
| <a name="input_backend_health_check_delay"></a> [backend\_health\_check\_delay](#input\_backend\_health\_check\_delay) | Delay between health checks | `string` | `"10s"` | no |
| <a name="input_backend_health_check_http_code"></a> [backend\_health\_check\_http\_code](#input\_backend\_health\_check\_http\_code) | Expected HTTP status code for health check | `string` | `"200"` | no |
| <a name="input_backend_health_check_http_method"></a> [backend\_health\_check\_http\_method](#input\_backend\_health\_check\_http\_method) | HTTP method for health check | `string` | `"GET"` | no |
| <a name="input_backend_health_check_http_uri"></a> [backend\_health\_check\_http\_uri](#input\_backend\_health\_check\_http\_uri) | URI for HTTP health check | `string` | `"/"` | no |
| <a name="input_backend_health_check_max_retries"></a> [backend\_health\_check\_max\_retries](#input\_backend\_health\_check\_max\_retries) | Maximum number of health check retries | `number` | `2` | no |
| <a name="input_backend_health_check_timeout"></a> [backend\_health\_check\_timeout](#input\_backend\_health\_check\_timeout) | Health check timeout | `string` | `"10s"` | no |
| <a name="input_backend_server_ips"></a> [backend\_server\_ips](#input\_backend\_server\_ips) | List of backend server IPs | `list(string)` | n/a | yes |
| <a name="input_dns_project_id"></a> [dns\_project\_id](#input\_dns\_project\_id) | Scaleway project ID where the DNS zones and records are managed (required when dns\_zone is set) | `string` | `null` | no |
| <a name="input_dns_record_name"></a> [dns\_record\_name](#input\_dns\_record\_name) | Name of the DNS record, without the zone suffix (optional — no DNS resources are created if not set) | `string` | `null` | no |
| <a name="input_dns_record_ttl"></a> [dns\_record\_ttl](#input\_dns\_record\_ttl) | TTL for the DNS record | `number` | `300` | no |
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | DNS zone for the domain record (optional — no DNS or SSL resources are created if not set) | `string` | `null` | no |
| <a name="input_enable_ssl"></a> [enable\_ssl](#input\_enable\_ssl) | Whether to enable SSL/TLS with Let's Encrypt certificate (only applies when dns\_zone is set) | `bool` | `true` | no |
| <a name="input_frontend_inbound_port"></a> [frontend\_inbound\_port](#input\_frontend\_inbound\_port) | Inbound port for the frontend (e.g. 443 for HTTPS, 80 for HTTP) | `number` | n/a | yes |
| <a name="input_ignore_ssl_server_verify"></a> [ignore\_ssl\_server\_verify](#input\_ignore\_ssl\_server\_verify) | Whether the Load Balancer should skip backend server certificate verification | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the load balancer | `string` | n/a | yes |
| <a name="input_private_network_id"></a> [private\_network\_id](#input\_private\_network\_id) | Private network ID to attach the load balancer to | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Scaleway project ID | `string` | n/a | yes |
| <a name="input_ssl_subject_alternative_names"></a> [ssl\_subject\_alternative\_names](#input\_ssl\_subject\_alternative\_names) | Subject alternative names for the SSL certificate | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the load balancer | `list(string)` | `[]` | no |
| <a name="input_type"></a> [type](#input\_type) | Load balancer type | `string` | `"LB-S"` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Visibility of the load balancer: 'internal' or 'internet-facing' | `string` | `"internal"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Scaleway zone | `string` | `"fr-par-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_id"></a> [backend\_id](#output\_backend\_id) | ID of the backend |
| <a name="output_certificate_id"></a> [certificate\_id](#output\_certificate\_id) | ID of the SSL certificate (only set when SSL is enabled) |
| <a name="output_dns_record_fqdn"></a> [dns\_record\_fqdn](#output\_dns\_record\_fqdn) | Fully qualified domain name of the DNS record (only set when DNS is configured) |
| <a name="output_frontend_id"></a> [frontend\_id](#output\_frontend\_id) | ID of the frontend |
| <a name="output_lb_id"></a> [lb\_id](#output\_lb\_id) | ID of the load balancer |
| <a name="output_lb_ip_address"></a> [lb\_ip\_address](#output\_lb\_ip\_address) | Public IP address of the load balancer (null for internal LB) |
| <a name="output_lb_private_ip_address"></a> [lb\_private\_ip\_address](#output\_lb\_private\_ip\_address) | Private IP address of the load balancer |
<!-- END_TF_DOCS -->

## Authors

Module is maintained with help from [the community](https://github.com/scaleway-terraform-modules/terraform-scaleway-lb/graphs/contributors).

## License

Mozilla Public License 2.0 Licensed. See [LICENSE](https://github.com/scaleway-terraform-modules/terraform-scaleway-lb/tree/master/LICENSE) for full details.