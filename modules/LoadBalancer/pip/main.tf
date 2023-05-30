#-----------------------------------
# Public IP for Load Balancer
#-----------------------------------

resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  location            = var.pip_location
  resource_group_name = var.pip_resource_group_name
  allocation_method   = var.pip_allocation_method
  sku                 = var.pip_sku
  sku_tier            = var.pip_sku_tier
  domain_name_label   = var.pip_domain_name_label
  tags = var.pip_tags
}
