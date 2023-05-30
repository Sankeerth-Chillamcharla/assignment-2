resource "azurerm_storage_account" "sa" {
  name                          = var.sa-name
  resource_group_name           = var.sa-resource_group_name
  location                      = var.sa-location
  account_kind                  = var.sa-account_kind
  account_tier                  = var.sa-account_tier
  account_replication_type      = var.sa-account_replication_type
  public_network_access_enabled = var.sa-public_network_access_enabled
  
  blob_properties {
    delete_retention_policy {
      days = var.sa-delete_retention_policy-days
    }
    container_delete_retention_policy {
      days = var.sa-container_delete_retention_policy-days
    }
  }
  tags = var.sa-tags
}
