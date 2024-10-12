variable "resource_group_name" {
  description = "The name of the resource group in which to create the key vault."
  type        = string
}
  
variable "location" {
  description = "The Azure Region in which to create the key vault."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  type        = string
  
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  type        = string
}

variable "application_id" {
  description = "The Application ID that should be used for authenticating requests to the key vault."
  type        = string
}

variable "object_id" {
  description = "The Object ID that should be used for authenticating requests to the key vault."
  type        = string
  
}

