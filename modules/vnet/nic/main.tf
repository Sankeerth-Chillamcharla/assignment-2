resource "azurerm_network_interface" "jumpbox" {
  name                = var.nic-name
  location            = var.nic-location
  resource_group_name = var.nic-resource_group_name
  ip_configuration {
    name                          = var.nic-ip-config-name
    subnet_id                     = var.nic-subnet_id
    private_ip_address_allocation = var.nic-private_ip_address_allocation
    public_ip_address_id          = var.nic-public_ip_address_id
  }
  tags = var.nic-tags
}
