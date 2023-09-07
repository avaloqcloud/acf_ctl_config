# output oci_load_balancer_load_balancer {
#     #Required
#     value = {
#         compartment_id = var.setting.parent_id
#         display_name   = format("%s_%s_compartment", var.setting.name, domain.name)
#         shape          = "Flexible"
#         subnets        = format("%s_%s_subnet_endpoint", var.setting.name, domain.name)

#         #Optional
#         defined_tags = {}
#         freeform_tags = {}
#         ip_mode = var.load_balancer_ip_mode
#         is_private = var.load_balancer_is_private
#         network_security_group_ids = var.load_balancer_network_security_group_ids
#         reserved_ips = {id = var.load_balancer_reserved_ips_id}
#         shape_details = {
#             #Required
#             maximum_bandwidth_in_mbps = var.load_balancer_shape_details_maximum_bandwidth_in_mbps
#             minimum_bandwidth_in_mbps = var.load_balancer_shape_details_minimum_bandwidth_in_mbps
#         }
#     }
# }

output "oci_core_vcn" {
    value = {for zone in local.zones : zone.name => {
        name           = format("%s_%s_compartment", var.setting.name, zone.name)
        compartment_id = var.setting.parent_id
        description    = zone.description
        cidr           = zone.cidr
    } if zone.stage <= var.setting.stage }
}
