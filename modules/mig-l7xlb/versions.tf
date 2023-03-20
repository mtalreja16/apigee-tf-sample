/**
 * Copyright 2022 Google. This software is provided as-is,
 * without warranty or representation for any use or purpose.
 * Your use of it is subject to your agreement with Google.
*/

terraform {
  required_version = ">= 1.1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.20.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.20.0"
    }
  }
}
