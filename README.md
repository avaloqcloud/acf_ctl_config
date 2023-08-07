<!---- Copyright (c) 2023 Avaloq and/or its affiliates. ---->
<!---- Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.  ---->

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/avaloqcloud/dev/archive/refs/heads/main.zip)

# Avaloq Cloud Framework

*DRAFT: Don't Use - Still Under Development*

The Avaloq Cloud Framework (ACF) is a collection of deployment scripts that connect cloud services running on Azure, AWS or Google with applications running on Oracle Cloud Infrastructure (OCI). [![License](https://img.shields.io/badge/license-apache-green)](https://www.apache.org/licenses/LICENSE-2.0)

## Configuration Module
The configuration module produces a set of topology definitions on form of Terraform resource blocks for cloud provider specific provisioning modules, it makes Terraform settings dynamic, taking cloud controller input and dependencies into account to output template configuration data. Deployment modules invoke elements of configuration data that are be unique and specific to a particular deployment, but generally represents elements of configuration that are used across different implementations. Some examples of this include:

- Enforcing resource naming conventions
- Define IP ranges 
- Firewall Configurations
- Role based access controls


## Requirements

In the configuration module parameter are captured in JSON format and stored in the '/param' directory. The configuration module parses parameters through with the terraform engine to create the resource blocks that inherit use case realted dependencies. Instead of client specific scripts, use case specific parameter is applied to a harmonized logic.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.previous](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [oci_identity_availability_domains.tenancy](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains) | data source |
| [oci_identity_compartment.parent](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_compartment) | data source |
| [oci_identity_regions.tenancy](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_regions) | data source |
| [oci_identity_tenancy.account](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_tenancy) | data source |
| [oci_objectstorage_namespace.tenancy](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/objectstorage_namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | Configuration parameter from the active oci account | <pre>object({<br>    class          = number,<br>    compartment_id = string,<br>    compliance     = list(any),<br>    home           = string,<br>    location       = string,<br>    name           = string,<br>    parent_id      = string,<br>    label          = string,<br>    owner          = string,<br>    services       = string,<br>    stage          = number,<br>    source         = string,<br>    scope          = list(any),<br>    tenancy_id     = string,<br>    user_id        = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oci_identity_compartment"></a> [oci\_identity\_compartment](#output\_oci\_identity\_compartment) | n/a |
| <a name="output_oci_identity_group"></a> [oci\_identity\_group](#output\_oci\_identity\_group) | n/a |
| <a name="output_oci_identity_user"></a> [oci\_identity\_user](#output\_oci\_identity\_user) | n/a |
| <a name="output_oci_identity_tag_namespace"></a> [oci\_identity\_tag\_namespace](#output\_oci\_identity\_tag\_namespace) | n/a |
| <a name="output_oci_identity_tag"></a> [oci\_identity\_tag](#output\_oci\_identity\_tag) | n/a |
| <a name="output_oci_ons_notification_topic"></a> [oci\_ons\_notification\_topic](#output\_oci\_ons\_notification\_topic) | n/a |
| <a name="output_oci_identity_policy"></a> [oci\_identity\_policy](#output\_oci\_identity\_policy) | n/a |

## Contributing

This project is a community project the code is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Avaloq appreciates any contributions that are made by the open source community. Extending the functionlaity it is advisable to utilize the [Avaloq Development Module (ADM)](https://github.com/avaloqcloud/acf_ctl_dev).

## License

Copyright (c) 2023 Avaloq and/or its affiliates.
Licensed under the Apache License, Version 2.0.
See [license](https://www.apache.org/licenses/LICENSE-2.0) for more details.

AVALOQ DOES NOT PROVIDE ANY WARRANTY FOR SOFTWARE CONTAINED WITHIN THIS REPOSITORY AND NO CUSTOMARY SECURITY REVIEW HAS BEEN PERFORMED. THIRD PARTIES MAY HAVE POSTED SOFTWARE, MATERIAL OR CONTENT TO THIS REPOSITORY WITHOUT ANY REVIEW. USE AT YOUR OWN RISK. 