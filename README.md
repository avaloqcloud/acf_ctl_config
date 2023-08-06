<!---- Copyright (c) 2023 Avaloq and/or its affiliates. ---->
<!---- Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.  ---->

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/avaloqcloud/dev/archive/refs/heads/main.zip)

# Avaloq Cloud Framework

*DRAFT: still under development*

The Avaloq Cloud Framework (ACF) is a collection of deployment scripts that connect cloud services running on Azure, AWS or Google with applications running on Oracle Cloud Infrastructure (OCI). [![License](https://img.shields.io/badge/license-apache-green)](https://www.apache.org/licenses/LICENSE-2.0)

## Configuration Module
A root configuration module initializes a base set of re-usable topology configurations that serve different use cases. The configuration module doesn`t create any resources but resource definitions for cloud provider specific provisioning modules, it makes Terraform settings dynamic, taking cloud controller input and dependencies into account to output template configuration data. Deployment modules invoke elements of configuration data that are be unique and specific to a particular deployment, but generally represents elements of configuration that are used across different implementations. Some examples of this include:

- Resource naming conventions
- On-premises IP ranges for resource firewalls
- Groups for RBAC roles

In the configuration module these parameter are captured in JSON format and stored in the '/param' directory. The configuration module parses parameters through with the terraform engine to create the resource blocks that inherit use case realted dependencies. Instead of client specific scripts, use case specific parameter is applied to a harmonized logic.

## Parameterization
...

## Contributing
This project is a community project the code is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Avaloq appreciates any contributions that are made by the open source community. Extending the functionlaity it is advisable to utilize the [Avaloq Development Module (ADM)](https://github.com/avaloqcloud/acf_ctl_dev).

## License
Copyright (c) 2023 Avaloq and/or its affiliates.

Licensed under the Apache License, Version 2.0.

See [license](https://www.apache.org/licenses/LICENSE-2.0) for more details.

AVALOQ DOES NOT PROVIDE ANY WARRANTY FOR SOFTWARE CONTAINED WITHIN THIS REPOSITORY AND NO CUSTOMARY SECURITY REVIEW HAS BEEN PERFORMED. THIRD PARTIES MAY HAVE POSTED SOFTWARE, MATERIAL OR CONTENT TO THIS REPOSITORY WITHOUT ANY REVIEW. USE AT YOUR OWN RISK. 
