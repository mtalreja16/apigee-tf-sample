/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

locals {
  subnet_exposure     = merge(var.subnet_exposure, { region = var.region })
  # subnet_proxy_only   = merge(var.subnet_proxy_only, { region = var.region })
}

module "project" {
  source          = "github.com/terraform-google-modules/cloud-foundation-fabric//modules/project?ref=v16.0.0"
  name            = var.project_id
  parent          = var.project_parent
  billing_account = var.billing_account
  project_create  = var.project_create
  services = [
    // Misc
    "cloudkms.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    // Apigee
    "apigee.googleapis.com",
    // GCIP
    "identitytoolkit.googleapis.com",
    // CloudRun
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "cloudbuild.googleapis.com",
  ]
}

module "vpc" {
  source             = "github.com/terraform-google-modules/cloud-foundation-fabric//modules/net-vpc?ref=v16.0.0"
  project_id         = module.project.project_id
  name               = var.network
  subnets            = [local.subnet_exposure]
  # subnets_proxy_only = [local.subnet_proxy_only]
  psa_config = {
    ranges = {
      apigee-range         = var.peering_ip_cidr_range
      apigee-support-range = var.support_ip_cidr_range
    }
    routes = null
  }
}

