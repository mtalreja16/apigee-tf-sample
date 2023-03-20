/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

variable "project_id" {
  description = "Project id (also used for the Apigee Organization)."
  type        = string
}

variable "project_parent" {
  description = "Parent folder or organization in 'folders/folder_id' or 'organizations/org_id' format."
  type        = string
  default     = null
  validation {
    condition     = var.project_parent == null || can(regex("(organizations|folders)/[0-9]+", var.project_parent))
    error_message = "Parent must be of the form folders/folder_id or organizations/organization_id."
  }
}

variable "project_create" {
  description = "Create project. When set to false, uses a data source to reference existing project."
  type        = bool
  default     = false
}


variable "billing_account" {
  description = "Billing account id."
  type        = string
  default     = null
}


variable "network" {
  description = "Name of the VPC network to peer with the Apigee tennant project."
  type        = string
}

variable "region" {
  description = "GCP region for storing Apigee analytics data (see https://cloud.google.com/apigee/docs/api-platform/get-started/install-cli)."
  type        = string
}


variable "instance_ip_cidr_range" {
  description = "Apigee Instance IP CIDR range."
  type        = string
}

variable "peering_ip_cidr_range" {
  description = "Service Peering CIDR range."
  type        = string
}

variable "support_ip_cidr_range" {
  description = "Support CIDR range of length /28 (required by Apigee for troubleshooting purposes)."
  type        = string
}

variable "subnet_exposure" {
  description = "Subnet for exposing Apigee services"
  type = object({
    name               = string
    ip_cidr_range      = string
    secondary_ip_range = map(string)
  })
}

variable "externaly_exposed_paths" {
  description = "Paths to externaly expose over L7 GLB"
  type        = list(string)
}

