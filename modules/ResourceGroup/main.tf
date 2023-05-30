resource "azurerm_resource_group" "az-rg" {
  name     = upper("RG-${var.rg-name}")
  location = var.rg-location
  tags     = var.rg-tags
}
