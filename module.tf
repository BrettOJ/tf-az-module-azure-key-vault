
resource "azurerm_key_vault" "key_vault" {
  name                            = module.akv_name.naming_convention_output[var.naming_convention_info.name].names.0
  location                        = var.location
  resource_group_name             = var.resource_group_name
  sku_name                        = var.sku_name
  tenant_id                       = var.tenant_id
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  dynamic "network_acls" {
    for_each = var.network_acls != null ? [var.network_acls] : []
    content {
      bypass                     = network_acls.bypass
      default_action             = network_acls.default_action
      ip_rules                   = network_acls.ip_rules
      virtual_network_subnet_ids = network_acls.virtual_network_subnet_ids
    }
  }
  purge_protection_enabled        = var.purge_protection_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days
  tags = var.tags
}

