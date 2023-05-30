output "vnet-name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet-address" {
  value = azurerm_virtual_network.vnet.address_space
}


output "vnet-id" {
  value = azurerm_virtual_network.vnet.id
}
