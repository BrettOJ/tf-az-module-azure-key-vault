
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
  purge_protection_enabled        = var.purge_protection_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days

  dynamic access_policy {
    for_each = var.access_policies != null ? [var.access_policies] : []
    content {
      tenant_id = access_policy.value.tenant_id
      object_id = access_policy.value.object_id
      application_id = access_policy.value.application_id
      certificate_permissions = access_policy.value.certificate_permissions
      key_permissions = access_policy.value.key_permissions
      secret_permissions = access_policy.value.secret_permissions
      storage_permissions = access_policy.value.storage_permissions
    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [var.network_acls] : []
    content {
      default_action             = network_acls.default_action
      bypass                     = network_acls.bypass
      ip_rules                   = network_acls.ip_rules
      virtual_network_subnet_ids = network_acls.virtual_network_subnet_ids
    }
  }

  tags = {
    environment = "Terraform"
  }

  dynamic "contact" {
    for_each = var.contact != null ? [var.contact] : []
    content {
      email = contact.email
      name  = contact.name
      phone = contact.phone
    }
  }
}

