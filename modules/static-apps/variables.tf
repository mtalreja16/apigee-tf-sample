/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

variable "apps" {
  type        = set(string)
  description = "Set of apps to create bucketes and hostnames for."
}

variable "project_id" {
  description = "Project id."
  type        = string
}


variable "region" {
  description = "Region."
  type        = string
}


variable "external_ip" {
  description = "External IP for the L7 XLB."
  type        = string
}

variable "external_hostname" {
  description = "External hostnames for the L7 XLB."
  type        = string
}

variable "ssl_certificate" {
  description = "SSL certificate for the HTTPS LB."
  type        = string
}
