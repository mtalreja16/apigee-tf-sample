/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

variable "project_id" {
  description = "Project id."
  type        = string
}

variable "backend_migs" {
  description = "List of MIGs to be used as backends."
  type        = list(string)
}

variable "ssl_certificate" {
  description = "SSL certificate for the HTTPS LB."
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

variable "name" {
  description = "External LB name."
  type        = string
}

variable "externaly_exposed_paths" {
  description = "Paths to externaly expose over L7 GLB"
  type        = list(string)
}
