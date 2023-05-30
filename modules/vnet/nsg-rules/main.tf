resource "azurerm_network_security_rule" "nsg-rules" {
  name                        = var.nsgr-name
  direction                   = var.nsgr-direction
  access                      = var.nsgr-access
  priority                    = var.nsgr-priority
  protocol                    = var.nsgr-protocol
  source_port_range           = var.nsgr-source_port_range
  destination_port_range      = var.nsgr-destination_port_range
  source_address_prefix       = var.nsgr-source_address_prefix
  destination_address_prefix  = var.nsgr-destination_address_prefix
  resource_group_name         = var.nsgr-resource_group_name
  network_security_group_name = var.nsgr-network_security_group_name
}