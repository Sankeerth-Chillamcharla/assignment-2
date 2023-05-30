
resource "azurerm_virtual_machine" "virtualmachine" {
  name                  = var.vm-name
  location              = var.vm-location
  resource_group_name   = var.vm-resource_group_name
  network_interface_ids = var.vm-network_interface_ids
  vm_size               = var.vm-size
  storage_image_reference {
    publisher = var.vm-os-publisher
    offer     = var.vm-os-offer
    sku       = var.vm-os-sku
    version   = var.vm-os-version
  }
  storage_os_disk {
    name              = var.vm-os-disk-name
    caching           = var.vm-os-disk-caching
    create_option     = var.vm-os-disk-create_option
    managed_disk_type = var.vm-os-disk-managed_disk_type
  }
  os_profile {
    computer_name  = var.vm-os-p-computer_name
    admin_username = var.vm-os-p-admin_username
    admin_password = var.vm-os-p-admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = var.vm-disable_password_authentication
  }

  tags = var.vm-tags
}







