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

module "resource_groups" {
  source = "git::https://github.com/BrettOJ/tf-az-module-resource-group?ref=main"
  resource_groups = {
    1 = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.naming_convention_info
      tags = {

      }
    }
  }
}

module "akv_example" {
  source              = "../" 
  resource_group_name = module.resource_groups.rg_output[1].name
  location            = var.location
  sku_name    = "premium"
  tenant_id           = var.tenant_id
  access_policies       = [
    {
      tenant_id               = var.tenant_id
      object_id               = var.object_id
      application_id          = var.application_id
      certificate_permissions = ["get", "list"]
      key_permissions         = ["get", "list"]
      secret_permissions      = ["get", "list"]
      storage_permissions     = ["get", "list"]
    }
  ]
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  enable_rbac_authorization       = true
  purge_protection_enabled        = true
  public_network_access_enabled   = true
  soft_delete_retention_days      = 7 


  network_acls = [
    {
      bypass         = "AzureServices"
      default_action = "Allow"
      ip_rules       = null
      subnet_ids     = null
    }
  ]
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
}