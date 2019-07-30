/*****
Common: Remote state backend
*****/
terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
  required_version = ">= 0.12"
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
  delimiter          = "-"
  additional_tag_map = {} /* Additional attributes (e.g. 1) */
  label_order        = ["environment", "namespace", "name", "attributes"] /* Default label order */
  tags = {
    "project" = var.project
  }
}

module "vnet" {
  source              = "git@github.com:mashbynz/tf-mod-azure-vnet?ref=master"
  context             = module.label.context
  region              = var.region
  ssvnet_addressspace = var.ssvnet_addressspace
  # ssvnetddos_name       = var.ssvnetddos_name
  # gatewaynsg_name       = var.gatewaynsg_name
  # gatewaysubnet_name    = var.gatewaysubnet_name
  gatewaysubnet_prefix = var.gatewaysubnet_prefix
  # firewallsubnet_name   = var.firewallsubnet_name
  firewallsubnet_prefix = var.firewallsubnet_prefix
  # GatewayRT_name        = var.GatewayRT_name
  GatewayRT_prefix      = var.GatewayRT_prefix
  GatewayRT_nexthoptype = var.GatewayRT_nexthoptype
  GatewayRT_nexthopIP   = var.GatewayRT_nexthopIP
}
