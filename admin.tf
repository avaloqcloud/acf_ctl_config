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
        class          = var.account.class
    } if group.stage  <= var.account.stage }
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

output "notifications" {
    value = {for channel in local.channels : channel.name => {
        name = format("%s_%s", var.account.name, channel.name)
        protocol  = channel.service
        endpoint  = channel.address
    } if contains(distinct(local.subscriptions[*].channel), channel.name)}
}

output "tag_namespaces" {
     value = {
        for namespace in local.controls : format("%s_%s", var.account.name, namespace.name) => namespace.stage
    }
}
/*
output "tags" {
     value = {for tag in local.tags : tag.name => {
        name          = tag.name
        namespace     = local.tag_map[tag.name]
        stage         = local.tag_namespaces["${local.tag_map[tag.name]}"]
        values        = tag.values
        default       = length(flatten([tag.values])) > 1 ? element(tag.values,0) : tostring(tag.values)
        cost_tracking = tag.cost_tracking
    }}
}

output "permissions" {
     value = {for permission in local.permissions : permission.name => {
        name        = "${local.service_name}_${operator.name}"
        compartment = local.group_map[operator.name]
        rules       = operator.rules
    }if contains(keys(local.group_map), operator.name) }
}
*/