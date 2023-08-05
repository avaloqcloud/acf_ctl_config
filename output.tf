// Copyright (c) 2023 Avaloq and/or its affiliates.
// Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.

// readme.md created with https://terraform-docs.io/: terraform-docs markdown --sort=false ./ > ./readme.md

output "tenancy_id" {
  description = "The Oracle Cloud Identifier (OCID) for the service compartment. It allows to retrieve the compartment details using data blocks."
  value       = data.oci_identity_tenancy.account.id
}

output "regions" {
  description = "The Oracle Cloud Identifier (OCID) for the service compartment. It allows to retrieve the compartment details using data blocks."
  value       = {for region in data.oci_identity_regions.tenancy.regions : region.key  => region.name}
}

output "home" {
  description = "The Oracle Cloud Identifier (OCID) for the service compartment. It allows to retrieve the compartment details using data blocks."
  value       = data.oci_identity_tenancy.account.home_region_key
}

output "availability_domains" {
  description = "The Oracle Cloud Identifier (OCID) for the service compartment. It allows to retrieve the compartment details using data blocks."
  value       = {for ad in data.oci_identity_availability_domains.tenancy.availability_domains : ad.name  => ad.id}
}
/*
output "objectstorage_namespace" {
  description = "The Oracle Cloud Identifier (OCID) for the service compartment. It allows to retrieve the compartment details using data blocks."
  value       = data.oci_objectstorage_namespace.tenancy
}

output "parent_id" {
  description = "The OCID of the parent compartment for the service."
  value       = oci_identity_compartment.account
}
output "compartment_ids" {
  description = "A list of OCID for the child compartments, representing the different administration domain."
  value       = { for compartment in oci_identity_compartment.domains : compartment.name => compartment.id }
}


output "tag_ids" {
  description = "A list of tags, created in the tag namespaces."
  value       = { for tag in oci_identity_tag.resident : tag.name => tag.id }
}

output "group_ids" {
  description = "A list of groups, created for the service in the tenancy or root compartment. This allows to define separate policies for every service. Group names have to be unique."
  value       = { for group in oci_identity_group.resident : group.name => group.id }
}

output "notifications" {
  description = "A list of notifcation topics, defined for a resident."
  value       = { for topic in oci_ons_notification_topic.resident : topic.name => topic.id }
}

output "policy_ids" {
  description = "A list of policy controls, defined for the different admistrator roles. Policy names correspond with the groups defined on tenancy level."
  value       = { for policy in oci_identity_policy.domains : policy.name => policy.id }
}

output "namespace_ids" {
  description = "A list of tag_namespaces created for the service compartment in the tenancy. This allows to define separate tags for every service. Namespace names have to be unique."
  value       = { for namespace in oci_identity_tag_namespace.account : namespace.name => namespace.id }
}

output "freeform_tags" {
  description = "A list of predefined freeform tags, referenced in the provisioning process."
  value = local.freeform_tags
}

output "defined_tags" {
  description = "A list of actionable tags, utilized for operation, budget- and compliance control."
  value = local.defined_tags
}
*/