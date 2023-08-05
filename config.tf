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
  parameter = concat([
    fileset("${path.module}/param/iam", "*.json"),
    fileset("${path.module}/param/net", "*.json"),
    fileset("${path.module}/param/crypto", "*.json"),
    fileset("${path.module}/param/data", "*.json")
  ])
}

resource "null_resource" "previous" {}
resource "time_sleep" "wait" {
  depends_on      = [null_resource.previous]
  create_duration = "2m"
}