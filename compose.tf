// Copyright (c) 2023 Avaloq and/or its affiliates.
// Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.

// readme.md created with https://terraform-docs.io/: terraform-docs markdown --sort=false ./ > ./readme.md

terraform {
    required_providers {
        oci = {
            source = "hashicorp/oci"
        }
    }
}

// metadata for the tenancy
data "oci_identity_tenancy" "resident" { tenancy_id = var.tenancy.id }

locals {
  defined_tags = {
    for tag in var.resident.tags : "${tag.namespace}.${tag.name}" => tag.default
    if tag.stage <= var.resident.stage
  }
  freeform_tags = {
    "framework" = "ocloud"
    "owner"     = var.resident.owner
    "lifecycle" = var.resident.stage
    "class"     = var.tenancy.class
  }
}

// --- define the wait state 
resource "null_resource" "previous" {}

// this resource will destroy (potentially immediately) after null_resource.next
resource "time_sleep" "wait" {
  depends_on      = [null_resource.previous]
  create_duration = "2m"
}