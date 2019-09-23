
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
