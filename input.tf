// Copyright (c) 2023 Avaloq and/or its affiliates.
// Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.

// readme.md created with https://terraform-docs.io/: terraform-docs markdown --sort=false ./ > ./readme.md

variable "account" {
  type = object({
    tenancy_id     = string,
    compartment_id = string,
    home           = string,
    user_id        = string
  })
  description = "Settings for the service resident"
}

variable "schema" {
  type = object({
    class        = string,
    parent       = string,
    location     = string,
    organization = string,
    project      = string,
    owner        = string,
    stage        = string,
    source       = string,
    scope        = list(any)
  })
  description = "Service Configuration"
}