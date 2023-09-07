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

data "oci_identity_tenancy"              "account" {tenancy_id     = var.setting.tenancy_id}
data "oci_identity_regions"              "tenancy" {}
data "oci_identity_availability_domains" "tenancy" {compartment_id = var.setting.tenancy_id}
data "oci_objectstorage_namespace"       "tenancy" {compartment_id = var.setting.tenancy_id}
data "oci_identity_compartment"          "parent"  {id             = var.setting.parent_id}

locals {
  # identity and access service parameter
  alerts        = jsondecode(file("${path.module}/param/iam/alert.json"))
  budgets       = jsondecode(file("${path.module}/param/iam/budget.json"))
  channels      = jsondecode(file("${path.module}/param/iam/channel.json"))
  controls      = jsondecode(file("${path.module}/param/iam/control.json"))
  domains       = jsondecode(file("${path.module}/param/iam/domain.json"))
  notifications = jsondecode(file("${path.module}/param/iam/notification.json"))
  permissions   = jsondecode(file("${path.module}/param/iam/permission.json"))
  roles         = jsondecode(file("${path.module}/param/iam/role.json"))
  subscriptions = jsondecode(file("${path.module}/param/iam/subscription.json"))
  tags          = jsondecode(file("${path.module}/param/iam/tag.json"))
  users         = jsondecode(file("${path.module}/param/iam/user.json"))
  # crypto service parameter
  secrets       = jsondecode(file("${path.module}/param/crypto/secret.json"))
  signatures    = jsondecode(file("${path.module}/param/crypto/signature.json"))
  vaults        = jsondecode(file("${path.module}/param/crypto/vault.json"))
  wallets       = jsondecode(file("${path.module}/param/crypto/wallet.json"))
  # network service parameter
  clusters      = jsondecode(file("${path.module}/param/net/cluster.json"))
  firewals      = jsondecode(file("${path.module}/param/net/firewall.json"))
  gateways      = jsondecode(file("${path.module}/param/net/gateway.json"))
  ports         = jsondecode(file("${path.module}/param/net/port.json"))
  segments      = jsondecode(file("${path.module}/param/net/segment.json"))
  subnets       = jsondecode(file("${path.module}/param/net/subnet.json"))
  zones         = jsondecode(file("${path.module}/param/net/zone.json"))
  # database service parameter
  databases     = jsondecode(file("${path.module}/param/db/system.json"))
  sizes         = jsondecode(file("${path.module}/param/db/size.json"))
  # compute service parameter
  filesystems   = jsondecode(file("${path.module}/param/compute/filesystem.json"))
  # file service parameter
  backups       = jsondecode(file("${path.module}/param/file/backup.json"))
  buckets       = jsondecode(file("${path.module}/param/file/bucket.json"))
  
  # Merge tags with with the respective namespace information
  tag_map = zipmap(
    flatten([for tag in local.controls[*].tags : tag]),
    flatten([for control in local.controls : [for tag in control.tags : "${var.setting.name}_${control.name}"]])
  ) 
  tag_namespaces = {for namespace in local.controls : "${var.setting.name}_${namespace.name}" => namespace.stage} 

}

resource "null_resource" "previous" {}
resource "time_sleep" "wait" {
  depends_on      = [null_resource.previous]
  create_duration = "2m"
}
