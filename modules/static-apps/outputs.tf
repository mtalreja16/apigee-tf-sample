/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

output "fqdns" {
  description = "All sub-domains FQDNS"
  value       = local.fqdns
}

output "bucket_names" {
  description = "All Buckets"
  value       = { for app in var.apps : app => google_storage_bucket.static[app].name }
}
