/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

locals {
  name  = "static-apps"
  fqdns = { for app in var.apps : app => "${app}.${var.external_hostname}" }
}

resource "google_storage_bucket" "static" {
  for_each                    = var.apps
  project                     = var.project_id
  name                        = "${var.project_id}-${each.key}"
  location                    = var.region
  uniform_bucket_level_access = true
  force_destroy               = true
  storage_class               = "STANDARD"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}

resource "google_storage_bucket_iam_binding" "public_rule" {
  for_each = var.apps
  bucket   = google_storage_bucket.static[each.key].id
  role     = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_compute_backend_bucket" "static" {
  for_each    = var.apps
  project     = var.project_id
  name        = each.key
  description = "Bucket for hosting static app \"${each.key}\""
  bucket_name = google_storage_bucket.static[each.key].name
  enable_cdn  = false
}


resource "google_compute_url_map" "url_map" {
  project = var.project_id
  name    = local.name

  # default_service = google_compute_backend_bucket.static["apps"].id

  default_url_redirect {
    host_redirect          = "google.com"
    path_redirect          = "/404"
    redirect_response_code = "TEMPORARY_REDIRECT"
    strip_query            = true
  }

  dynamic "host_rule" {
    for_each = var.apps
    content {
      hosts        = [local.fqdns[host_rule.key]]
      path_matcher = host_rule.key
    }
  }

  dynamic "path_matcher" {
    for_each = var.apps
    content {
      name            = path_matcher.key
      default_service = google_compute_backend_bucket.static[path_matcher.key].id
    }
  }
}

resource "google_compute_target_https_proxy" "https_proxy" {
  project          = var.project_id
  name             = "${local.name}-target-proxy"
  url_map          = google_compute_url_map.url_map.id
  ssl_certificates = [var.ssl_certificate]
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  project               = var.project_id
  name                  = local.name
  load_balancing_scheme = "EXTERNAL_MANAGED"
  target                = google_compute_target_https_proxy.https_proxy.id
  ip_address            = var.external_ip != null ? var.external_ip : null
  port_range            = "443"
}

