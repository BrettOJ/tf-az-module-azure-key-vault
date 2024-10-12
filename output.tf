# output file for an Azure key vault module using Terraform

output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.key_vault.id
}
