/*****
Common Variables: Azure provider - Autoloaded from Terragrunt.
*****/

variable "region" {
  description = "The Azure region (e.g. australia east). Autoloaded from region.tfvars."
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

variable "project" {
  type        = string
  default     = ""
  description = "the internal project name"
}

variable "class" {
  type        = string
  default     = ""
  description = "the type of resource e.g. 'sharedservices' or 'app1'"
}

variable "analytics_name" {
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

variable "vnet_addressspace" {
  type        = list(string)
  description = ""
  default     = []
}

variable "gateway_subnet_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "firewall_subnet_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_rt_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_rt_nexthop_type" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_rt_nexthop_ip" {
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

variable "vpngw_private_alloc" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_client_address" {
  type        = list(string)
  description = ""
  default     = []
}

/*****
PaaS Module Variables - https://github.com/mashbynz/tf-mod-azure-vnet
*****/

variable "sharedservices_vnet_id" {
  type        = string
  description = ""
  default     = ""
}
