/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

output "apigee_xlb_hostname" {
  description = "External load balancer hostname (HTTPS)"
  value       = module.apigee-nip-development-hostname.hostname
}

output "apps_fqdns" {
  description = "Static web apps FQDNS"
  value       = module.apps.fqdns
}

output "apps_buckets" {
  description = "Static web apps buckets"
  value       = module.apps.bucket_names
}

