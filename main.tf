/*****
Common: Remote state backend
*****/
terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "azurerm" {}
  required_version = ">= 0.12"
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  version         = "1.28.0"
}

/*****
Modules: tf-proj-auzre-baseline - "git@github.com:mashbynz/tf-proj-azure-baseline?ref=master"
*****/

module "label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
  attributes         = var.attributes
  delimiter          = ""
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "name", "attributes"] /* Default label order */
  tags = {
    "project"    = var.project
    "costcenter" = var.costcentre
  }
}


module "vnet" {
  source                     = "git::https://github.com/mashbynz/tf-mod-azure-vnet.git?ref=master"
  context                    = module.label.context
  region                     = var.region
  vnet_addressspace          = var.vnet_addressspace
  gateway_subnet_prefix      = var.gateway_subnet_prefix
  firewall_subnet_prefix     = var.firewall_subnet_prefix
  gateway_rt_prefix          = var.gateway_rt_prefix
  gateway_rt_nexthop_type    = var.gateway_rt_nexthop_type
  gateway_rt_nexthop_ip      = var.gateway_rt_nexthop_ip
  firewall_allocation_method = var.firewall_allocation_method
  firewall_sku               = var.firewall_sku
  vpngw_allocation_method    = var.vpngw_allocation_method
  vpngw_type                 = var.vpngw_type
  vpngw_vpn_type             = var.vpngw_vpn_type
  vpngw_sku                  = var.vpngw_sku
  vpngw_private_alloc        = var.vpngw_private_alloc
  vpngw_client_address       = var.vpngw_client_address
}

