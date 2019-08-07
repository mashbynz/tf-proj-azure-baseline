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
  version         = "1.28"
}

/*****
Modules: tf-proj-auzre-baseline - "git@github.com:mashbynz/tf-proj-azure-baseline?ref=master"
*****/

module "ae_sharedserviceslabel" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.ae_sharedservices_name
  attributes         = var.attributes
  delimiter          = ""
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["name", "attributes"] /* Default label order */
  tags = {
    "project"    = var.project
    "costcenter" = var.costcentre
  }
}

module "ase_sharedserviceslabel" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.ase_sharedservices_name
  attributes         = var.attributes
  delimiter          = ""
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["name", "attributes"] /* Default label order */
  tags = {
    "project"    = var.project
    "costcenter" = var.costcentre
  }
}

module "paaslabel" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.loganalytics_name
  attributes         = var.attributes
  delimiter          = ""
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["name", "attributes"] /* Default label order */
  tags = {
    "project"    = var.project
    "costcenter" = var.costcentre
  }
}

module "ae_vnet" {
  source                     = "git::https://github.com/mashbynz/tf-mod-azure-vnet.git?ref=master"
  context                    = module.ae_sharedserviceslabel.context
  region                     = var.primaryregion
  vnet_addressspace          = var.vnet_ae_addressspace
  gateway_subnet_prefix      = var.ae_gateway_subnet_prefix
  firewall_subnet_prefix     = var.ae_firewall_subnet_prefix
  gateway_rt_prefix          = var.ae_gateway_rt_prefix
  gateway_rt_nexthop_type    = var.ae_gateway_rt_nexthop_type
  gateway_rt_nexthop_ip      = var.ae_gateway_rt_nexthop_ip
  firewall_allocation_method = var.firewall_allocation_method
  firewall_sku               = var.firewall_sku
  vpngw_allocation_method    = var.vpngw_allocation_method
  vpngw_type                 = var.vpngw_type
  vpngw_vpn_type             = var.vpngw_vpn_type
  vpngw_sku                  = var.vpngw_sku
  vpngw_private_alloc        = var.vpngw_private_alloc
  vpngw_client_address       = var.ae_vpngw_client_address
}

module "ase_vnet" {
  source                     = "git::https://github.com/mashbynz/tf-mod-azure-vnet.git?ref=master"
  context                    = module.ase_sharedserviceslabel.context
  region                     = var.secondaryregion
  vnet_addressspace          = var.vnet_ase_addressspace
  gateway_subnet_prefix      = var.ase_gateway_subnet_prefix
  firewall_subnet_prefix     = var.ase_firewall_subnet_prefix
  gateway_rt_prefix          = var.ase_gateway_rt_prefix
  gateway_rt_nexthop_type    = var.ase_gateway_rt_nexthop_type
  gateway_rt_nexthop_ip      = var.ase_gateway_rt_nexthop_ip
  firewall_allocation_method = var.firewall_allocation_method
  firewall_sku               = var.firewall_sku
  vpngw_allocation_method    = var.vpngw_allocation_method
  vpngw_type                 = var.vpngw_type
  vpngw_vpn_type             = var.vpngw_vpn_type
  vpngw_sku                  = var.vpngw_sku
  vpngw_private_alloc        = var.vpngw_private_alloc
  vpngw_client_address       = var.ase_vpngw_client_address
}

module "paas" {
  source                          = "git::https://github.com/mashbynz/tf-mod-azure-paas.git?ref=master"
  context                         = module.paaslabel.context
  region                          = var.primaryregion
  log_analytics_sku               = var.log_analytics_sku
  log_analytics_retention_in_days = var.log_analytics_retention_in_days
  solution_publisher              = var.solution_publisher
  solution_AzureActivity          = var.solution_AzureActivity
}
