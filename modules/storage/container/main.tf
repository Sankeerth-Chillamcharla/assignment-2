
resource "azurerm_storage_container" "saccontainer" {
  name                  = var.sac-name
  storage_account_name  = var.sac-storage_account_name
  // container_access_type = var.sac-container_access_type
}