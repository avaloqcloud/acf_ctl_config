// Copyright (c) 2023 Avaloq and/or its affiliates.
// Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.

output "oci_budget_alert_rule" {
    value = { for alert in local.alerts : alert.name => {
        name           = format("%s_%s", var.setting.name, group)
        compartment_id = var.setting.parent_id
        controls       = var.setting.controls
        description    = "${group} role defined for ${data.oci_identity_compartment.parent.name} identity domain"
        
    }
    }
}

output "oci_identity_compartment" {
    value = {for domain in local.domains : domain.name => {
        name           = format("%s_%s_compartment", var.setting.name, domain.name)
        compartment_id = var.setting.parent_id
        controls       = var.setting.controls
        description    = domain.description
        defined_tags   = {"budget.cost_center"= domain.cost_center}
        freeform_tags  = {"department" = domain.department}
    } if domain.stage <= var.setting.stage }
}

output "oci_identity_group" {
    value = {for group in distinct(local.users[*].role) : group => {
        name           = format("%s_%s", var.setting.name, group)
        compartment_id = var.setting.parent_id
        controls       = var.setting.controls
        description    = "${group} role defined for ${data.oci_identity_compartment.parent.name} identity domain"
    }}
}

output "oci_identity_user" {
    value = {for user in local.users : user.email => {
        name           = user.email
        compartment_id = var.setting.parent_id
        controls       = var.setting.controls
        description    = format("%s %s", user.first_name, user.last_name)
        defined_tags   = {"budget.cost_center"= user.cost_center}
        email          = user.email
        freeform_tags  = {"department" = user.department}
    } if user.stage <= var.setting.stage }
}

output "oci_identity_tag_namespace" {
    value = {for namespace in local.controls : namespace.name => {
        name           = format("%s_%s", var.setting.name, namespace.name)
        compartment_id = var.setting.parent_id
        controls       = var.setting.controls
        description    = "${namespace.name} control for ${data.oci_identity_compartment.parent.name} identity domain"
    } if namespace.stage <= var.setting.stage }
}

output "oci_identity_tag" {
    value = {for tag in local.tags : tag.name => {
        name             = tag.name
        controls         = var.setting.controls
        description      = "${tag.name} control"
        tag_namespace_id = local.tag_map[tag.name]
        values           = tag.values
        default          = length(flatten([tag.values])) > 1 ? element(tag.values,0) : tostring(tag.values)
        is_cost_tracking = tag.cost_tracking
    } if local.tag_namespaces["${local.tag_map[tag.name]}"] <= var.setting.stage }
}

output "oci_ons_notification_topic" {
    value = {for channel in local.channels : channel.name => {
        name           = format("%s_%s_%s", var.setting.name, channel.service, channel.name)
        compartment_id = var.setting.parent_id
        controls       = var.setting.controls
        protocol       = channel.service
        endpoint       = channel.address
    } if contains(distinct(local.subscriptions[*].channel), channel.name)}
}

output "oci_identity_policy" {
    value = {for permission in local.permissions : permission.role => {
        name           = format("%s_%s_policy", var.setting.name, permission.role)
        compartment_id = var.setting.parent_id
        controls       = var.setting.controls
        description    = permission.policy
        statements     = permission.permissions
    }... if contains(distinct(local.users[*].role), permission.role) }
}