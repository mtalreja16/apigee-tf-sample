/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

project_id      = "gcip-oidc-demo"
project_parent  = "folders/123"
billing_account = "0AB"

network = "apigee-network"
region  = "us-central1"

instance_ip_cidr_range = "10.0.0.0/22"
peering_ip_cidr_range  = "10.0.0.0/22"
support_ip_cidr_range  = "10.1.0.0/28"

subnet_exposure = {
  name               = "apigee-exposure"
  ip_cidr_range      = "10.100.0.0/24"
  secondary_ip_range = {}
}

externaly_exposed_paths = [
  "/.well-known/*",
  "/oauth2/*",
  "/api/*",
]
