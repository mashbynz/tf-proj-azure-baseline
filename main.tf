/*****
Common: Remote state backend
*****/
terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
  #   required_version = ">= 0.12"
}

data "azurerm_client_config" "current" {
}

provider "azuread" {
  version = "<=0.6.0"
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  version         = "1.28"
  # version = "<= 1.33.1"
}

/*****
Modules: tf-proj-auzre-baseline - "git@github.com:mashbynz/tf-proj-azure-baseline?ref=master"
*****/

module "vnet" {
  source       = "github.com/Callumccr/tf-mod-azure-vnet?ref=master"
  context      = module.label.context
  vnet_enabled = var.vnet_config.vnet_enabled
  vnet_config  = var.vnet_config
}

# #Specify the subscription logging repositories 
# module "activity_logs" {
#   source = "git://github.com/aztfmod/activity_logs.git?ref=v0.5"

#   # prefix              = var.prefix
#   resource_group_name = module.resource_group_hub.names["HUB-CORE-SEC"]
#   location            = var.location
#   tags                = var.tags_hub
#   logs_rentention     = var.azure_activity_logs_retention
# }

# #Specify the operations diagnostic logging repositories 
# module "diagnostics_logging" {
#   source = "git://github.com/aztfmod/diagnostics_logging.git?ref=v0.1"

#   # prefix              = var.prefix
#   resource_group_name = module.resource_group_hub.names["HUB-OPERATIONS"]
#   location            = var.location
#   tags                = var.tags_hub
# }

# # Create the Azure Monitor - Log Analytics workspace
# module "log_analytics" {
#   source = "git://github.com/aztfmod/log_analytics.git?ref=v0.1"

#   # prefix              = var.prefix
#   # name                = var.analytics_workspace_name
#   resource_group_name = module.resource_group_hub.names["HUB-OPERATIONS"]
#   location            = var.location
#   solution_plan_map   = var.solution_plan_map
# }

# # Create the Azure Security Center workspace
# module "security_center" {
#   source = "git://github.com/aztfmod/azure_security_center.git?ref=v0.8"

#   contact_email = var.security_center["contact_email"]
#   contact_phone = var.security_center["contact_phone"]
#   scope_id      = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
#   workspace_id  = module.log_analytics.log_analytics_workspace_id
# }


# # module "expressroute" {
# #   source               = "git::https://github.com/mashbynz/tf-mod-azure-gw.git?ref=feature/express_route"
# #   context              = module.label.context
# #   enabled              = var.express_route_config.enabled
# #   express_route_config = var.express_route_config
# #   resource_group_name  = module.vnet.rg_name
# #   gateway_subnet_id    = module.vnet.gateway_subnet_id
# # }
