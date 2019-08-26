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
  context    = module.label.context
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
  context              = module.label.context
  enabled              = true
  express_route_config = var.express_route_config
  resource_group_name  = module.vnet.rg_name
  gateway_subnet_id    = module.vnet.gateway_subnet_id
}

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
