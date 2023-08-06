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
  # administrator service parameter
  users         = jsondecode(file("${path.module}/param/admin/user.json"))
  roles         = jsondecode(file("${path.module}/param/admin/role.json"))
  privileges    = jsondecode(file("${path.module}/param/admin/privilege.json"))
  subscriptions = jsondecode(file("${path.module}/param/admin/subscription.json"))
  notifications = jsondecode(file("${path.module}/param/admin/notification.json"))
  domains       = jsondecode(file("${path.module}/param/admin/domain.json"))
  alerts        = jsondecode(file("${path.module}/param/admin/alert.json"))
  budgets       = jsondecode(file("${path.module}/param/admin/budget.json"))
  channels      = jsondecode(file("${path.module}/param/admin/channel.json"))
  # network service parameter
  clusters      = jsondecode(file("${path.module}/param/net/cluster.json"))
  firewals      = jsondecode(file("${path.module}/param/net/firewall.json"))
  gateways      = jsondecode(file("${path.module}/param/net/gateway.json"))
  ports         = jsondecode(file("${path.module}/param/net/port.json"))
  segments      = jsondecode(file("${path.module}/param/net/segment.json"))
  subnets       = jsondecode(file("${path.module}/param/net/subnet.json"))
  zones         = jsondecode(file("${path.module}/param/net/zone.json"))
  # crypto service parameter
  secrets       = jsondecode(file("${path.module}/param/crypto/secret.json"))
  signatures    = jsondecode(file("${path.module}/param/crypto/signature.json"))
  vaults        = jsondecode(file("${path.module}/param/crypto/vault.json"))
  wallets       = jsondecode(file("${path.module}/param/crypto/wallet.json"))
  # database service parameter
  databases     = jsondecode(file("${path.module}/param/db/database.json"))
  sizes         = jsondecode(file("${path.module}/param/db/size.json"))
  # compute service parameter
  filesystems   = jsondecode(file("${path.module}/param/compute/filesystem.json"))
  # file service parameter
  buckets       = jsondecode(file("${path.module}/param/file/bucket.json"))
  backups       = jsondecode(file("${path.module}/param/file/backup.json"))
}

resource "null_resource" "previous" {}
resource "time_sleep" "wait" {
  depends_on      = [null_resource.previous]
  create_duration = "2m"
}