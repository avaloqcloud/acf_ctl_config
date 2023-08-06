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
  description = "Prepopulated parameter from the active oci account"
}

variable "schema" {
  type = object({
    class        = number,
    location     = string,
    organization = string,
    parent       = string,
    project      = string,
    owner        = string,
    services     = string,
    stage        = number,
    source       = string,
    scope        = list(any)
  })
  description = "Service Configuration"
}