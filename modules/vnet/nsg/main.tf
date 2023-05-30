resource "azurerm_network_security_group" "appnsg" {
  name = upper("NSG-${var.nsg-name}")
  location = var.nsg-location-name
  resource_group_name = var.nsg-rg-name
  tags = var.nsg-tags
}




