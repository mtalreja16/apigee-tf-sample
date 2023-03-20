/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

locals {
  apps = [
    "client",
    "login",
  ]
}

module "apps-nip-development-hostname" {
  source             = "github.com/apigee/terraform-modules//modules/nip-development-hostname?ref=v0.2.1"
  project_id         = module.project.project_id
  address_name       = "apps-external"
  subdomain_prefixes = local.apps
}

module "apps" {
  source            = "../../modules/static-apps"
  project_id        = module.project.project_id
  region            = var.region
  external_ip       = module.apps-nip-development-hostname.ip_address
  external_hostname = module.apps-nip-development-hostname.hostname
  ssl_certificate   = module.apps-nip-development-hostname.ssl_certificate
  apps              = local.apps
}

module "apps_service_accounts" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "~> 4.0"
  project_id = module.project.project_id
  prefix     = "gcip-apps"
  names      = ["backend"]
  project_roles = []
}
