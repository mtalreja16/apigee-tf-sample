/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

resource "google_compute_health_check" "mig_lb_hc" {
  project = var.project_id
  name    = "${var.name}-hc"
  https_health_check {
    port         = "443"
    request_path = "/healthz/ingress"
  }
}

resource "google_compute_backend_service" "mig_backend" {
  project               = var.project_id
  name                  = "${var.name}-backend"
  port_name             = "https"
  protocol              = "HTTPS"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.mig_lb_hc.id]
  dynamic "backend" {
    for_each = var.backend_migs
    content {
      group = backend.value
    }
  }
}

resource "google_compute_url_map" "url_map" {
  project = var.project_id
  name    = var.name
  # default_service = google_compute_backend_service.mig_backend.id
  default_url_redirect {
    host_redirect          = "google.com"
    path_redirect          = "/404"
    redirect_response_code = "TEMPORARY_REDIRECT"
    strip_query            = true
  }
  host_rule {
    hosts        = [var.external_hostname]
    path_matcher = "main"
  }
  path_matcher {
    name = "main"
    default_url_redirect {
      host_redirect          = "google.com"
      path_redirect          = "/404"
      redirect_response_code = "TEMPORARY_REDIRECT"
      strip_query            = true
    }
    path_rule {
      paths   = var.externaly_exposed_paths
      service = google_compute_backend_service.mig_backend.id
    }
  }
}

resource "google_compute_target_https_proxy" "https_proxy" {
  project          = var.project_id
  name             = "${var.name}-target-proxy"
  url_map          = google_compute_url_map.url_map.id
  ssl_certificates = [var.ssl_certificate]
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  project               = var.project_id
  load_balancing_scheme = "EXTERNAL_MANAGED"
  name                  = var.name
  target                = google_compute_target_https_proxy.https_proxy.id
  ip_address            = var.external_ip != null ? var.external_ip : null
  port_range            = "443"
}
