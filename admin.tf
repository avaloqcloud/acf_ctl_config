// Copyright (c) 2023 Avaloq and/or its affiliates.
// Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.

output "oci_identity_compartment" {
    value = {for domain in local.domains : domain.name => {
        name           = format("%s_%s_compartment", var.account.name, domain.name)
        compartment_id = var.account.parent_id
        description    = domain.description
        class          = var.account.class
        defined_tags   = {"budget.cost_center"= domain.cost_center}
        freeform_tags  = {"department" = domain.department}
    } if domain.stage <= var.account.stage }
}

output "oci_identity_group" {
    value = {for group in distinct(local.users[*].role) : group => {
        name           = format("%s_%s", var.account.name, group)
        compartment_id = var.account.parent_id
        description    = "${group} role defined for ${var.account.parent_id}"
    }}
}

output "oci_identity_user" {
    value = {for user in local.users : user.email => {
        compartment_id = var.account.parent_id
        name           = user.email
        description    = format("%s %s", user.first_name, user.last_name)
        defined_tags   = {"budget.cost_center"= user.cost_center}
        email          = user.email
        freeform_tags  = {"department" = user.department}
        class          = var.account.class
    } if user.stage <= var.account.stage }
}

output "oci_ons_notification_topic" {
    value = {for channel in local.channels : channel.name => {
        compartment_id = var.account.parent_id
        name           = format("%s_%s_%s", var.account.name, channel.service, channel.name)
        protocol       = channel.service
        endpoint       = channel.address
    } if contains(distinct(local.subscriptions[*].channel), channel.name)}
}

output "oci_identity_tag_namespace" {
     value = {for namespace in local.controls : namespace.name => {
        compartment_id = var.account.parent_id
        description    = "${namespace.name} control for ${var.account.parent_id}"
        name           = format("%s_%s", var.account.name, namespace.name)
    } if namespace.stage <= var.account.stage }
}

output "oci_identity_tag" {
     value = {for tag in local.tags : tag.name => {
        name             = tag.name
        description      = "${tag.name} control"
        tag_namespace_id = local.tag_map[tag.name]
        values           = tag.values
        default          = length(flatten([tag.values])) > 1 ? element(tag.values,0) : tostring(tag.values)
        is_cost_tracking = tag.cost_tracking
    } if local.tag_namespaces["${local.tag_map[tag.name]}"] <= var.account.stage }
}
/*
output "permissions" {
     value = {for permission in local.permissions : permission.name => {
        name        = "${local.service_name}_${operator.name}"
        compartment = local.group_map[operator.name]
        rules       = operator.rules
    }if contains(keys(local.group_map), operator.name) }
}
*/