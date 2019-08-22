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

variable "ae_sharedservices_name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'baseline'"
}

variable "ase_sharedservices_name" {
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

variable "vnet_ae_addressspace" {
  type        = list(string)
  description = ""
  default     = []
}

variable "vnet_ase_addressspace" {
  type        = list(string)
  description = ""
  default     = []
}

variable "ae_gateway_subnet_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "ase_gateway_subnet_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "ae_firewall_subnet_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "ase_firewall_subnet_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "ae_gateway_rt_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "ase_gateway_rt_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "ae_gateway_rt_nexthop_type" {
  type        = string
  description = ""
  default     = ""
}

variable "ase_gateway_rt_nexthop_type" {
  type        = string
  description = ""
  default     = ""
}

variable "ae_gateway_rt_nexthop_ip" {
  type        = string
  description = ""
  default     = ""
}

variable "ase_gateway_rt_nexthop_ip" {
  type        = string
  description = ""
  default     = ""
}

variable "firewall_allocation_method" {
  type        = string
  description = ""
  default     = ""
}

variable "firewall_sku" {
  type        = string
  description = ""
  default     = ""
}

/*****
GATEWAY Module Variables - https://github.com/mashbynz/tf-mod-azure-vnet
*****/

variable "vpngw_allocation_method" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_type" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_vpn_type" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_sku" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_ip_sku" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_private_alloc" {
  type        = string
  description = ""
  default     = ""
}

variable "ae_vpngw_client_address" {
  type        = list(string)
  description = ""
  default     = []
}

variable "ase_vpngw_client_address" {
  type        = list(string)
  description = ""
  default     = []
}

variable "ae_vpn_client_protocols" {
  type        = list(string)
  description = ""
  default     = []
}

variable "ase_vpn_client_protocols" {
  type        = list(string)
  description = ""
  default     = []
}

/*****
EXPRESSROUTE Module Variables - https://github.com/mashbynz/tf-mod-azure-vnet
*****/

vvariable "express_route_config" {
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
    advertised_public_prefixes    = {}
    peering_location              = {}
    provider_name                 = {}
    bandwidth_in_mbps             = {}
    tier                          = ""
    family                        = ""
    peering_type                  = ""
    peer_asn                      = null
    vlan_id                       = null
    ergw_allocation_method        = ""
    ergw_ip_sku                   = ""
    ergw_type                     = ""
    ergw_sku                      = ""
    ergw_private_allocation       = ""
  }
  description = "Default express route configuration"
}


/*****
PaaS Module Variables - https://github.com/mashbynz/tf-mod-azure-vnet
*****/

variable "sharedservices_vnet_id" {
  type        = string
  description = ""
  default     = ""
}

variable "log_analytics_retention_in_days" {
  type        = number
  description = ""
  default     = 0
}

variable "log_analytics_sku" {
  description = ""
  default     = ""
}

variable "solution_publisher" {
  type        = string
  description = ""
  default     = ""
}

variable "solution_AzureActivity" {
  type        = string
  description = ""
  default     = ""
}

variable "security_center_scope" {
  type        = string
  description = ""
  default     = ""
}

/*****
IAM Module Variables - https://github.com/mashbynz/tf-mod-azure-vnet
*****/

variable "owner_role_definition" {
  type        = string
  description = ""
  default     = ""
}

variable "contributor_role_definition" {
  type        = string
  description = ""
  default     = ""
}

variable "reader_role_definition" {
  type        = string
  description = ""
  default     = ""
}

variable "sub_owner" {
  type        = string
  description = ""
  default     = ""
}

variable "sub_owner_ad_group_id" {
  type        = string
  description = ""
  default     = ""
}

variable "sub_reader" {
  type        = string
  description = ""
  default     = ""
}

variable "sub_reader_ad_group_id" {
  type        = string
  description = ""
  default     = ""
}

variable "prodloganalytics1_owner" {
  type        = string
  description = ""
  default     = ""
}

variable "prologanalytics1_owner_ad_group_id" {
  type        = string
  description = ""
  default     = ""
}

variable "prodloganalytics1_contributor" {
  type        = string
  description = ""
  default     = ""
}

variable "prologanalytics1_contributor_ad_group_id" {
  type        = string
  description = ""
  default     = ""
}

variable "prodloganalytics1_reader" {
  type        = string
  description = ""
  default     = ""
}

variable "prodloganalytics1_reader_ad_group_id" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices1_owner" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices1_owner_ad_group_id" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices1_contributor" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices1_contributor_ad_group_id" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices1_reader" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices1_reader_ad_group_id" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices2_owner" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices2_owner_ad_group_id" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices2_contributor" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices2_contributor_ad_group_id" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices2_reader" {
  type        = string
  description = ""
  default     = ""
}

variable "prodsharedservices2_reader_ad_group_id" {
  type        = string
  description = ""
  default     = ""
}
