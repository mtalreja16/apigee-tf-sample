# HTTPS Loadbalancer for Managed Instance Group Backend

<!-- BEGIN_TF_DOCS -->
Copyright 2022 Google. This software is provided as-is,
without warranty or representation for any use or purpose.
Your use of it is subject to your agreement with Google.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.20.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_backend_service.mig_backend](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service) | resource |
| [google_compute_global_forwarding_rule.forwarding_rule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_health_check.mig_lb_hc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) | resource |
| [google_compute_target_https_proxy.https_proxy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_https_proxy) | resource |
| [google_compute_url_map.url_map](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_migs"></a> [backend\_migs](#input\_backend\_migs) | List of MIGs to be used as backends. | `list(string)` | n/a | yes |
| <a name="input_external_hostname"></a> [external\_hostname](#input\_external\_hostname) | External hostnames for the L7 XLB. | `string` | n/a | yes |
| <a name="input_external_ip"></a> [external\_ip](#input\_external\_ip) | External IP for the L7 XLB. | `string` | n/a | yes |
| <a name="input_externaly_exposed_paths"></a> [externaly\_exposed\_paths](#input\_externaly\_exposed\_paths) | Paths to externaly expose over L7 GLB | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | External LB name. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project id. | `string` | n/a | yes |
| <a name="input_ssl_certificate"></a> [ssl\_certificate](#input\_ssl\_certificate) | SSL certificate for the HTTPS LB. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->