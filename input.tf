// Copyright (c) 2023 Avaloq and/or its affiliates.
// Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.

// readme.md created with https://terraform-docs.io/: terraform-docs markdown --sort=false ./ > ./readme.md

variable "account" {
  type = object({
    class          = number,
    compartment_id = string,
    compliance     = list(any),
    home           = string,
    location       = string,
    name           = string,
    parent_id      = string,
    label          = string,
    owner          = string,
    services       = string,
    stage          = number,
    source         = string,
    scope          = list(any),
    tenancy_id     = string,
    user_id        = string
  })
  description = "Configuration parameter from the active oci account"
}