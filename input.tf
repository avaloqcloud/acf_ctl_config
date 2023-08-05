// Copyright (c) 2023 Avaloq and/or its affiliates.
// Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.

// readme.md created with https://terraform-docs.io/: terraform-docs markdown --sort=false ./ > ./readme.md

variable "input" {
  type = object({
    parent_id     = string,
    enable_delete = bool
  })
  description = "Settings for the service resident"
}

variable "tenancy" {
  type = object({
    class   = number,
    buckets = string,
    id      = string,
    region  = map(string)
  })
  description = "Tenancy Configuration"
}

variable "resident" {
  type = object({
    owner          = string,
    name           = string,
    label          = string,
    stage          = number,
    region         = map(string)
    compartments   = map(number),
    repository     = string,
    groups         = map(string),
    policies       = map(any),
    notifications  = map(any),
    tag_namespaces = map(number),
    tags           = any
  })
  description = "Service Configuration"
}