locals {
  tags = {
    "created-by" = "Terraform"

  }

  naming_convention_info = {
    name         = "eg"
    project_code = "boj"
    env          = "dev"
    zone         = "z1"
    agency_code  = "brettoj"
    tier         = "web"
  }
}
data "azurerm_client_config" "current" {}

module "resource_groups" {
  source = "git::https://github.com/BrettOJ/tf-az-module-resource-group?ref=main"
  resource_groups = {
    1 = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.naming_convention_info
      tags = local.tags
    }
  }
}

module "azurerm_user_assigned_identity" {
  source                 = "git::https://github.com/BrettOJ/tf-az-module-auth-user-msi?ref=main"
  resource_group_name    = module.resource_groups.rg_output[1].name
  location               = var.location
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
}

module "akv_example" {
  source              = "../"
  resource_group_name = module.resource_groups.rg_output[1].name
  location            = var.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  enable_rbac_authorization       = true
  network_acls = null
  purge_protection_enabled        = true
  public_network_access_enabled   = true
  soft_delete_retention_days      = 7



  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
}