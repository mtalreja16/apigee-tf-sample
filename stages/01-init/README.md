# Basic Apigee X Setup with internal Endpoint

## Setup Instructions

Please see the main [README](https://github.com/apigee/terraform-modules#deploying-end-to-end-samples)
for detailed instructions.

<!-- BEGIN_TF_DOCS -->
Copyright 2022 Google. This software is provided as-is,
without warranty or representation for any use or purpose.
Your use of it is subject to your agreement with Google.

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_apigee-x-bridge-mig"></a> [apigee-x-bridge-mig](#module\_apigee-x-bridge-mig) | github.com/apigee/terraform-modules//modules/apigee-x-bridge-mig | v0.2.1 |
| <a name="module_apigee-x-core"></a> [apigee-x-core](#module\_apigee-x-core) | github.com/apigee/terraform-modules//modules/apigee-x-core | v0.2.1 |
| <a name="module_firewall_rules"></a> [firewall\_rules](#module\_firewall\_rules) | github.com/terraform-google-modules/terraform-google-network//modules/firewall-rules | v5.2.0 |
| <a name="module_mig-l7ilb"></a> [mig-l7ilb](#module\_mig-l7ilb) | ../modules/mig-l7ilb | n/a |
| <a name="module_mig-l7xlb"></a> [mig-l7xlb](#module\_mig-l7xlb) | ../modules/mig-l7xlb | n/a |
| <a name="module_nip-development-hostname"></a> [nip-development-hostname](#module\_nip-development-hostname) | github.com/apigee/terraform-modules//modules/nip-development-hostname | v0.2.1 |
| <a name="module_project"></a> [project](#module\_project) | github.com/terraform-google-modules/cloud-foundation-fabric//modules/project | v16.0.0 |
| <a name="module_serverless-connector"></a> [serverless-connector](#module\_serverless-connector) | github.com/terraform-google-modules/terraform-google-network//modules/vpc-serverless-connector-beta | v5.2.0 |
| <a name="module_service_accounts"></a> [service\_accounts](#module\_service\_accounts) | terraform-google-modules/service-accounts/google | ~> 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | github.com/terraform-google-modules/cloud-foundation-fabric//modules/net-vpc | v16.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | Billing account id. | `string` | `null` | no |
| <a name="input_externaly_exposed_paths"></a> [externaly\_exposed\_paths](#input\_externaly\_exposed\_paths) | Paths to externaly expose over L7 GLB | `list(string)` | n/a | yes |
| <a name="input_instance_ip_cidr_range"></a> [instance\_ip\_cidr\_range](#input\_instance\_ip\_cidr\_range) | Apigee Instance IP CIDR range. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | Name of the VPC network to peer with the Apigee tennant project. | `string` | n/a | yes |
| <a name="input_peering_ip_cidr_range"></a> [peering\_ip\_cidr\_range](#input\_peering\_ip\_cidr\_range) | Service Peering CIDR range. | `string` | n/a | yes |
| <a name="input_project_create"></a> [project\_create](#input\_project\_create) | Create project. When set to false, uses a data source to reference existing project. | `bool` | `false` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project id (also used for the Apigee Organization). | `string` | n/a | yes |
| <a name="input_project_parent"></a> [project\_parent](#input\_project\_parent) | Parent folder or organization in 'folders/folder\_id' or 'organizations/org\_id' format. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region for storing Apigee analytics data (see https://cloud.google.com/apigee/docs/api-platform/get-started/install-cli). | `string` | n/a | yes |
| <a name="input_serverless_connector_ip_cidr_range"></a> [serverless\_connector\_ip\_cidr\_range](#input\_serverless\_connector\_ip\_cidr\_range) | IP CIDR range for CloudRun serverless connector | `string` | n/a | yes |
| <a name="input_subnet_exposure"></a> [subnet\_exposure](#input\_subnet\_exposure) | Subnet for exposing Apigee services | <pre>object({<br>    name               = string<br>    ip_cidr_range      = string<br>    secondary_ip_range = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_subnet_proxy_only"></a> [subnet\_proxy\_only](#input\_subnet\_proxy\_only) | Subnet for ILB Envoy proxies | <pre>object({<br>    name          = string<br>    ip_cidr_range = string<br>    active        = bool<br>  })</pre> | n/a | yes |
| <a name="input_support_ip_cidr_range"></a> [support\_ip\_cidr\_range](#input\_support\_ip\_cidr\_range) | Support CIDR range of length /28 (required by Apigee for troubleshooting purposes). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ilb_hostname"></a> [ilb\_hostname](#output\_ilb\_hostname) | Internal load balancer hostname (HTTP) |
| <a name="output_xlb_hostname"></a> [xlb\_hostname](#output\_xlb\_hostname) | External load balancer hostname (HTTPS) |
<!-- END_TF_DOCS -->