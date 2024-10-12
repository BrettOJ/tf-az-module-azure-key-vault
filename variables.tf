# variables file for an Azure key vault module using Terraform

variable "location" {
  description = "The Azure Region in which the Key Vault should be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault."
  type        = string
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  type        = string
}

variable "access_policy" {
  description = "A list of access_policy objects (up to 1024) describing access policies."
  type = list(object({
    tenant_id               = string
    object_id               = string
    application_id          = string
    certificate_permissions = list(string)
    key_permissions         = list(string)
    secret_permissions      = list(string)
    storage_permissions     = list(string)
  }))
  default = []
}

variable "enabled_for_deployment" {
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  type        = bool
  default     = false
}

variable "enable_rbac_authorization" {
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  type        = bool
  default     = false
}

variable "network_acls" {
  description = "A network_acls block as defined below."
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
}

variable "purge_protection_enabled" {
  description = "Is Purge Protection enabled for this Key Vault?"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for this Key Vault."
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted."
  type        = number
  default     = 90
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "naming_convention_info" {
  description = "A map of naming convention information."
  type        = map(string)

}

variable "contact" {
  description = "One or more contact block as defined below."
  type = list(object({
    email = string
    name  = string
    phone = string
  }))
  default = []
}


