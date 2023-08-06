// Copyright (c) 2023 Avaloq and/or its affiliates.
// Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.

output "compartments" {
     value = {for domain in local.domains : domain.name => {
        name      = "${var.account.name}_${domain.name}_compartment"
        parent_id = var.account.parent_id
        class     = var.account.class
        stage     = var.account.stage
    }}
}

output "groups" {
     value = {for group in local.users[*].role : group => {
        name = "${var.account.name}_${group}"
    }}
}

output "users" {
  value       = {
    for user in local.users : user.name => format("%s %s", user.first_name, user.last_name)
  }
}

/*
output "notifications" {
     value = {for channel in local.channels : "${local.service_name}_${channel.name}" => {
        topic     = "${local.service_name}_${channel.name}"
        protocol  = channel.type
        endpoint  = channel.address
    } if contains(distinct(flatten("${local.domains[*].channels}")), channel.name)}

output "policies" {
     value = {for operator in local.operators : operator.name => {
        name        = "${local.service_name}_${operator.name}"
        compartment = local.group_map[operator.name]
        rules       = operator.rules
    }if contains(keys(local.group_map), operator.name) }

output "region" {
     value = {
        key  = local.region_key
        name = local.region_name
    }
    
output "tag_namespaces" {
     value = {
        for namespace in local.controls : "${local.service_name}_${namespace.name}" => namespace.stage
    }
    
output "tags" {
     value = {for tag in local.tags : tag.name => {
        name          = tag.name
        namespace     = local.tag_map[tag.name]
        stage         = local.tag_namespaces["${local.tag_map[tag.name]}"]
        values        = tag.values
        default       = length(flatten([tag.values])) > 1 ? element(tag.values,0) : tostring(tag.values)
        cost_tracking = tag.cost_tracking
    }}
*/