variable "resource_group_name" {
  description = "The name of the resource group in which to create the key vault."
  type        = string
}

variable "location" {
  description = "The Azure Region in which to create the key vault."
  type        = string
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
  type        = string
}


