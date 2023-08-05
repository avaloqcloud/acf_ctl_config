// Copyright (c) 2023 Avaloq and/or its affiliates.
// Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.

// readme.md created with https://terraform-docs.io/: terraform-docs markdown --sort=false ./ > ./readme.md

terraform {
    required_providers {
        oci = {
            source = "oracle/oci"
        }
    }
}

data "oci_identity_tenancy"              "account" {tenancy_id     = var.account.tenancy_id}
data "oci_identity_regions"              "tenancy" {}
data "oci_identity_availability_domains" "tenancy" {compartment_id = var.account.tenancy_id}
data "oci_objectstorage_namespace"       "tenancy" {compartment_id = var.account.tenancy_id}

locals {
    # Discovering the home region name and region key.
    regions_map         = {for region in data.oci_identity_regions.tenancy.regions : region.key => region.name}
    regions_map_reverse = {for region in data.oci_identity_regions.tenancy.regions : region.name => region.key}
    # Deployment region
    region_key          = local.regions_map_reverse[var.solution.region]
    region_name         = var.solution.region
    # Home region key obtained from the tenancy data source
    home_region_key     = data.oci_identity_tenancy.resident.home_region_key
    # Region key obtained from the region name
    home_region_name    = local.regions_map[local.home_region_key]
    home_region_ads     = sort(data.template_file.ad_names.*.rendered)
}


/*
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
*/

resource "null_resource" "previous" {}
resource "time_sleep" "wait" {
  depends_on      = [null_resource.previous]
  create_duration = "2m"
}