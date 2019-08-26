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

module "label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  namespace          = var.namespace
  environment        = var.environment
  name               = var.name
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

module "vnet" {
  source     = "git::https://github.com/mashbynz/tf-mod-azure-vnet.git?ref=feature/express_route"
  context    = module.ae_sharedserviceslabel.context
  enabled    = true
  vpc_config = var.vpc_config
}

module "paas" {
  source                          = "git::https://github.com/mashbynz/tf-mod-azure-paas.git?ref=master"
  context                         = module.paaslabel.context
  region                          = var.primaryregion
  log_analytics_sku               = var.log_analytics_sku
  log_analytics_retention_in_days = var.log_analytics_retention_in_days
  solution_publisher              = var.solution_publisher
  solution_AzureActivity          = var.solution_AzureActivity
  security_center_scope           = var.security_center_scope
}

module "ae_expressroute" {
  source               = "git::https://github.com/mashbynz/tf-mod-azure-gw.git?ref=feature/express_route"
  context              = module.ae_sharedserviceslabel.context
  enabled              = true
  express_route_config = var.express_route_config
  resource_group_name  = list(module.ae_vnet.rg_name, module.ase_vnet.rg_name)
  gateway_subnet_id    = list(module.ae_vnet.gateway_subnet_id, module.ase_vnet.gateway_subnet_id)
}

# module "ase_expressroute" {
#   source  = "git::https://github.com/mashbynz/tf-mod-azure-gw.git?ref=master"
#   context = module.ase_sharedserviceslabel.context

#   region                     = var.secondaryregion
#   resource_group_name        = module.ase_vnet.rg_name
#   location                   = module.ase_vnet.rg_location
#   gateway_subnet_id          = module.ase_vnet.gateway_subnet_id
#   ergw_allocation_method     = var.ase_ergw_allocation_method
#   ergw_ip_sku                = var.ase_ergw_ip_sku
#   ergw_type                  = var.ase_ergw_type
#   ergw_sku                   = var.ase_ergw_sku
#   ergw_private_alloc         = var.ase_ergw_private_alloc
#   service_provider_name      = var.ase_service_provider_name
#   peering_location           = lookup(var.peering_location, "ase", "")
#   bandwidth_in_mbps          = var.ase_bandwidth_in_mbps
#   tier                       = var.ase_tier
#   family                     = var.ase_family
#   peering_type               = var.ase_peering_type
#   peer_asn                   = var.ase_peer_asn
#   vlan_id                    = var.ase_vlan_id
#   advertised_public_prefixes = var.ase_advertised_public_prefixes
# }

# module "VPNgateway" {
#   source               = "git::https://github.com/mashbynz/tf-mod-azure-gw.git?ref=master"
#   context              = module.ae_sharedserviceslabel.context
#   region               = var.primaryregion
# }

# RBAC role assignment

###################
# Already created
###################
# module "subscription_owner" {
#   source = "git::https://github.com/mashbynz/tf-mod-azure-iam.git?ref=master"
#   # context          = module.paaslabel.context
#   assignable_scope = var.sub_owner
#   role_definition  = var.owner_role_definition
#   ad_group_id      = var.sub_owner_ad_group_id
# }

# module "subscription_reader" {
#   source = "git::https://github.com/mashbynz/tf-mod-azure-iam.git?ref=master"
#   # context          = module.paaslabel.context
#   assignable_scope = var.sub_reader
#   role_definition  = var.reader_role_definition
#   ad_group_id      = var.sub_reader_ad_group_id
# }
###################
# Already created
###################

###################
# Uncomment when bug resolved: https://github.com/terraform-providers/terraform-provider-azurerm/issues/4058
###################
# module "prodloganalytics1_owner" {
#   source = "git::https://github.com/mashbynz/tf-mod-azure-iam.git?ref=master"
#   # context          = module.paaslabel.context
#   assignable_scope = var.prodloganalytics1_owner
#   role_definition  = var.owner_role_definition
#   ad_group_id      = var.prologanalytics1_owner_ad_group_id
# }

# module "prodloganalytics1_contributor" {
#   source = "git::https://github.com/mashbynz/tf-mod-azure-iam.git?ref=master"
#   # context          = module.paaslabel.context
#   assignable_scope = var.prodloganalytics1_contributor
#   role_definition  = var.contributor_role_definition
#   ad_group_id      = var.prologanalytics1_contributor_ad_group_id
# }

# module "prodloganalytics1_reader" {
#   source = "git::https://github.com/mashbynz/tf-mod-azure-iam.git?ref=master"
#   # context          = module.paaslabel.context
#   assignable_scope = var.prodloganalytics1_reader
#   role_definition  = var.reader_role_definition
#   ad_group_id      = var.prodloganalytics1_reader_ad_group_id
# }

# module "prodsharedservices1_owner" {
#   source = "git::https://github.com/mashbynz/tf-mod-azure-iam.git?ref=master"
#   # context          = module.paaslabel.context
#   assignable_scope = var.prodsharedservices1_owner
#   role_definition  = var.owner_role_definition
#   ad_group_id      = var.prodsharedservices1_owner_ad_group_id
# }

# module "prodsharedservices1_contributor" {
#   source = "git::https://github.com/mashbynz/tf-mod-azure-iam.git?ref=master"
#   # context          = module.paaslabel.context
#   assignable_scope = var.prodsharedservices1_contributor
#   role_definition  = var.contributor_role_definition
#   ad_group_id      = var.prodsharedservices1_contributor_ad_group_id
# }

# module "prodsharedservices1_reader" {
#   source = "git::https://github.com/mashbynz/tf-mod-azure-iam.git?ref=master"
#   # context          = module.paaslabel.context
#   assignable_scope = var.prodsharedservices1_reader
#   role_definition  = var.reader_role_definition
#   ad_group_id      = var.prodsharedservices1_reader_ad_group_id
# }

# module "prodsharedservices2_owner" {
#   source = "git::https://github.com/mashbynz/tf-mod-azure-iam.git?ref=master"
#   # context          = module.paaslabel.context
#   assignable_scope = var.prodsharedservices2_owner
#   role_definition  = var.owner_role_definition
#   ad_group_id      = var.prodsharedservices2_owner_ad_group_id
# }

# module "prodsharedservices2_contributor" {
#   source = "git::https://github.com/mashbynz/tf-mod-azure-iam.git?ref=master"
#   # context          = module.paaslabel.context
#   assignable_scope = var.prodsharedservices2_contributor
#   role_definition  = var.contributor_role_definition
#   ad_group_id      = var.prodsharedservices2_contributor_ad_group_id
# }

# module "prodsharedservices2_reader" {
#   source = "git::https://github.com/mashbynz/tf-mod-azure-iam.git?ref=master"
#   # context          = module.paaslabel.context
#   assignable_scope = var.prodsharedservices2_reader
#   role_definition  = var.reader_role_definition
#   ad_group_id      = var.prodsharedservices2_reader_ad_group_id
# }
###################
# Uncomment when bug resolved: https://github.com/terraform-providers/terraform-provider-azurerm/issues/4058
###################
