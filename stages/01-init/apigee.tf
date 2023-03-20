/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

locals {
  subnet_region_name  = "${var.region}/${var.subnet_exposure.name}"
  name                = "eval"
  bridge_network_tags = ["apigee-bridge"]
  apigee_xlb_name            = "apigee-xlb"
}

module "apigee-nip-development-hostname" {
  source       = "github.com/apigee/terraform-modules//modules/nip-development-hostname?ref=v0.2.1"
  project_id   = module.project.project_id
  address_name = "apigee-external"
}

module "apigee-x-core" {
  source       = "github.com/apigee/terraform-modules//modules/apigee-x-core?ref=v0.2.1"
  project_id          = module.project.project_id
  apigee_environments = [local.name]
  ax_region           = var.region
  network             = module.vpc.network.id
  apigee_instances = {
    "${local.name}" = {
      region       = var.region
      ip_range     = var.instance_ip_cidr_range
      environments = [local.name]
    }
  }
  apigee_envgroups = {
    "${local.name}" = {
      environments = [local.name]
      hostnames = [
        module.apigee-nip-development-hostname.hostname,
      ]
    }
  }
}

module "apigee-x-bridge-mig" {
  source       = "github.com/apigee/terraform-modules//modules/apigee-x-bridge-mig?ref=v0.2.1"
  project_id   = module.project.project_id
  network      = module.vpc.network.id
  subnet       = module.vpc.subnet_self_links[local.subnet_region_name]
  region       = var.region
  endpoint_ip  = module.apigee-x-core.instance_endpoints[local.name]
  network_tags = local.bridge_network_tags
}

module "mig-l7xlb" {
  source                  = "../../modules/mig-l7xlb"
  project_id              = module.project.project_id
  name                    = local.apigee_xlb_name
  backend_migs            = [module.apigee-x-bridge-mig.instance_group]
  ssl_certificate         = module.apigee-nip-development-hostname.ssl_certificate
  external_ip             = module.apigee-nip-development-hostname.ip_address
  external_hostname       = module.apigee-nip-development-hostname.hostname
  externaly_exposed_paths = var.externaly_exposed_paths
}

module "firewall_rules" {
  source       = "github.com/terraform-google-modules/terraform-google-network//modules/firewall-rules?ref=v5.2.0"
  project_id   = var.project_id
  network_name = module.vpc.network.name

  rules = [
    {
      name                    = "allow-iap-ssh-ingress"
      description             = null
      direction               = "INGRESS"
      priority                = 1000
      ranges                  = ["35.235.240.0/20"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
      deny = []
      log_config = null
    },
  ]
}

module "apigee_service_accounts" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "~> 4.0"
  project_id = module.project.project_id
  prefix     = "gcip-apigee"
  names      = ["gcip"]
  project_roles = [
    "${module.project.project_id}=>roles/firebaseauth.viewer",
  ]
}
