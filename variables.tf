/*****
Common Variables: Azure provider - Autoloaded from Terragrunt.
*****/


variable "primaryregion" {
  description = "The Azure region (e.g. 'australiaeast'). Autoloaded from region.tfvars."
  type        = string
  default     = ""
}

variable "secondaryregion" {
  description = "The Azure region (e.g. 'australiaeast'). Autoloaded from region.tfvars."
  type        = string
  default     = ""
}

variable "subscription_id" {
  description = "The Azure Subscription ID (e.g. 7e719999-342b-44a8-9cd2-eada38cb7f08). Autoloaded from subscription.tfvars."
  type        = string
  default     = ""
}

variable "tenant_id" {
  description = "The Azure Tenant ID (e.g. a4d44117-bb20-4668-a0dc-16fcb91100b7). Autoloaded from subscription.tfvars."
  type        = string
  default     = ""
}

variable "remote_state_blob" {
  description = "The Azure remote state blob. Autoloaded from the parent terragrunt.hcl"
  type        = string
  default     = ""
}

variable "remote_state_blob_region" {
  description = "The Azure remote state blob region. Autoloaded from the parent terragrunt.hcl"
  type        = string
  default     = ""
}

/*****
Label Module Variables - "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
*****/

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "costcentre" {
  type        = string
  default     = ""
  description = "Costcentre, which could be the cost centre or entity, e.g. 'ICT' or 'NZTA'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'baseline'"
}

variable "sharedservices_name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'baseline'"
}

variable "project" {
  type        = string
  default     = ""
  description = "the internal project name"
}

variable "loganalytics_name" {
  type        = string
  default     = ""
  description = "the type of resource e.g. 'sharedservices' or 'app1'"
}

variable "delimiter" {
  type        = string
  default     = ""
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

/*****
VNET Module Variables - https://github.com/mashbynz/tf-mod-azure-vnet
*****/

variable "vnet_config" {
  type = object({
    location     = map(string)
    vnet_enabled = bool
    address_space = object({
      ae  = list(string)
      ase = list(string)
    })
    gateway_prefix             = map(string)
    firewall_prefix            = map(string)
    rt_prefix                  = map(string)
    rt_nexthop_type            = map(string)
    rt_nexthop_ip              = map(string)
    firewall_allocation_method = string
    firewall_sku               = string
    # vpngw_allocation_method    = string
    # vpngw_type                 = string
    # vpngw_sku                  = string
    # vpngw_ip_sku               = string
    # vpngw_private_allocation   = string
    # client_address             = map(string)
    # vpn_client_protocol        = list(string)
    # gateway_rt_prefix          = string
    # gateway_rt_nexthop_type    = string
    # gateway_rt_nexthop_ip      = map(string)
  })

  default = {
    location     = {}
    vnet_enabled = true
    address_space = {
      ae  = []
      ase = []
    }
    gateway_prefix             = {}
    firewall_prefix            = {}
    rt_prefix                  = {}
    rt_nexthop_type            = {}
    rt_nexthop_ip              = {}
    firewall_allocation_method = null
    firewall_sku               = null
    # vpngw_allocation_method    = null
    # vpngw_type                 = null
    # vpngw_sku                  = null
    # vpngw_ip_sku               = null
    # vpngw_private_allocation   = null
    # client_address             = {}
    # vpn_client_protocol        = []
    # gateway_rt_prefix          = null
    # gateway_rt_nexthop_type    = null
    # gateway_rt_nexthop_ip      = {}
  }
  description = "Default VNET configuration"
}

/*****
EXPRESSROUTE Module Variables - https://github.com/mashbynz/tf-mod-azure-vnet
*****/

variable "express_route_config" {
  type = object({
    location                      = map(string)
    enabled                       = bool
    primary_peer_address_prefix   = list(string)
    secondary_peer_address_prefix = list(string)
    advertised_public_prefixes = object({
      ae  = list(string)
      ase = list(string)
    })
    peering_location        = map(string)
    provider_name           = map(string)
    bandwidth_in_mbps       = map(string)
    tier                    = string
    family                  = string
    peering_type            = string
    peer_asn                = number
    vlan_id                 = number
    ergw_allocation_method  = string
    ergw_ip_sku             = string
    ergw_type               = string
    ergw_sku                = string
    ergw_private_allocation = string
  })
  default = {
    location                      = {}
    enabled                       = true
    primary_peer_address_prefix   = []
    secondary_peer_address_prefix = []
    advertised_public_prefixes = {
      ae  = []
      ase = []
    }
    peering_location        = {}
    provider_name           = {}
    bandwidth_in_mbps       = {}
    tier                    = null
    family                  = null
    peering_type            = null
    peer_asn                = null
    vlan_id                 = null
    ergw_allocation_method  = null
    ergw_ip_sku             = null
    ergw_type               = null
    ergw_sku                = null
    ergw_private_allocation = null
  }
  description = "Default express route configuration"
}