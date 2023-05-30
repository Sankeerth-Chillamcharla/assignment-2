#---------------------------------------
# Virutal machine scale set
#---------------------------------------

resource "azurerm_linux_virtual_machine_scale_set" "vm-scale-set" {
  name                            = var.vs_name
  resource_group_name             = var.vs_resource_group_name
  location                        = var.vs_location 
  sku                             = var.vs_sku
  instances                       = var.vs_instance_count
  admin_username                  = var.vs_admin_username
  admin_password                  = var.vs_admin_password
  zones                           = var.vs_zones
  zone_balance                    = var.vs_zone_balance
  disable_password_authentication = var.vs_disable_password_authentication

  source_image_reference {
    publisher = var.vs_os_publisher
    offer     = var.vs_os_offer
    sku       = var.vs_os_sku
    version   = var.vs_os_version
  }

  os_disk {
    storage_account_type = var.vs_os_disk_type
    caching              = var.vs_os_disk_cashing
    disk_size_gb         = var.vs_os_disk_size-gb
  }

  data_disk {
    lun                  = var.vs_data_lun
    storage_account_type = var.vs_data_disk_type
    caching              = var.vs_data_disk_cashing
    create_option        = var.vs_data_disk_creation_type
    disk_size_gb         = var.vs_data_disk_size_gb
  }

  network_interface {
    name                          = var.vs_nic_name
    primary                       = var.vs_nic_primary
    dns_servers                   = var.vs_dns_servers
    enable_ip_forwarding          = var.vs_enable_ip_forwarding
    enable_accelerated_networking = var.vs_enable_accelerated_networking
    network_security_group_id     = var.vs_nsg_id
    ip_configuration {
      name                                   = var.vs_ip_cofig_name
      primary                                = var.vs_ip-config-primary
      subnet_id                              = var.vs_ip_config_subnet_id
      load_balancer_backend_address_pool_ids = var.vs_load_balancer_backend_address_pool_ids
    }
  }

  tags = var.vm_tags
}






