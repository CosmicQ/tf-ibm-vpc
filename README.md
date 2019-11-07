# tf-ibm-vpc
Terrafom module for a VPC in "IBM VPC Classic"

_The current version is for Terraform v0.11_
_This will be updated once the IBM Cloud provider supports v.012_

# Overiew
This VPC module create a basic VPC in the IBM cloud.

This module will create the following resources:
* VPC
* Gateway
* Subnets
* (optional) VPN Gateway

# Usage example
An example of how to use the bastion module

(Super simple VPC)
```hcl
module "vpc" {
  source             = "github.com/CosmicQ/tf-ibm-vpc"
  name               = "simple"
  zones              = ["us-south-1"]
  prefixes           = ["10.100.0.0/16"]
  public_subnets     = ["10.100.11.0/24"]
  #private_subnets    = ["10.100.21.0/24","10.101.21.0/24"]
  #data_subnets       = ["10.100.31.0/24","10.101.31.0/24"]

  #create_vpn_gateway = true
}
```
A VPC example for a possible K8's cluster across three zones using three tiered architecture with VPN:
```hcl
module "vpc" {
  source             = "github.com/CosmicQ/tf-ibm-vpc"
  name               = "k8s"
  zones              = ["us-south-1","us-south-2","us-south-3"]
  prefixes           = ["10.100.0.0/16","10.101.0.0/16","10.102.0.0/16"]
  public_subnets     = ["10.100.11.0/24","10.101.11.0/24","10.102.11.0/24"]
  private_subnets    = ["10.100.21.0/24","10.101.21.0/24","10.102.11.0/24"]
  data_subnets       = ["10.100.31.0/24","10.101.31.0/24","10.102.11.0/24"]

  create_vpn_gateway = true
}
```


# Details
This module is inspired by the [AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc).  

## VPN
This module can create a VPN gateway PER ZONE.  This is because IBM Cloud does not offer peering between VPCs, _and_ 
in order to connect to resources in a multi-zone VPC, a VPN connection is required per zone (https://cloud.ibm.com/docs/vpc-on-classic?topic=vpc-on-classic-known-limitations)

# Inputs
```

             source - required
            version - optional
               name - required
              zones - required
           prefixes - required
     public_subnets - optional
    private_subnets - optional
       data_subnets - optional
 create_vpn_gateway - optional - default = false

```

# Outputs
```

           vpc_name = "Name of the VPC"
             vpc_id = "VPC ID"
           prefixes = "List of prefixes used"
     vpn_gateway_id = "List of VPN gateway IDs"
     vpn_gateway_ip = "List of VPN gateway IP addresses"
        gateway_ids = "List of gateway IDs"
        gateway_ips = "List of gateway IP addresses (in case you need to whitelist)"
  public_subnet_ids = "List of public subnet IDs"
 private_subnet_ids = "List of private subnet IDs"
   data_subnets_ids = "List of data subnet IDs"

```