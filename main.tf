#---------------------------------------
# Recource Group
#---------------------------------------
module "ResourceGroup" {
  source      = "./modules/ResourceGroup"
  rg-name     = "${var.project}-${var.application_name}"
  rg-location = var.location
  rg-tags = {
    Project     = upper("${var.project}")
    Environment = upper(var.env)
    Application = upper("${var.application_name}")
    Name        = "RG-${var.project}-${var.application_name}"
    Type        = "Resource Group"
    Company     = upper("${var.company_name}")
  }
}
#---------------------------------------
# Vnet
#---------------------------------------
module "vnet" {
  source                   = "./modules/vnet"
  vnet-name                = upper("VNET-${var.project}-${var.application_name}")
  vnet-location            = module.ResourceGroup.rg-location
  vnet-resource_group_name = module.ResourceGroup.rg-name
  vnet-cidr-range          = var.vnet-map
  depends_on               = [module.ResourceGroup]
  vnet-tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = "VNET-${var.project}-${var.application_name}"
    Type        = "VNET"
    Company     = upper("${var.company_name}")
  }
}
#---------------------------------------
# Application Subnet 
#---------------------------------------
module "appsubnet" {
  source                  = "./modules/vnet/subnets"
  sn-name                 = upper("App-${var.project}-${var.application_name}-${var.env}")
  sn-resource_group_name  = module.ResourceGroup.rg-name
  sn-virtual_network_name = module.vnet.vnet-name
  sn-address_prefixes     = [cidrsubnet(var.base_vnet_cidr, 2, 0)]
  sn-service-end-point    = ["Microsoft.Storage"]
  depends_on              = [module.vnet]
}
#---------------------------------------
# Jumphost Subnet
#---------------------------------------
module "jump-subnet" {
  source                  = "./modules/vnet/subnets"
  sn-name                 = upper("Jumphost-${var.project}-${var.application_name}-${var.env}")
  sn-resource_group_name  = module.ResourceGroup.rg-name
  sn-virtual_network_name = module.vnet.vnet-name
  sn-address_prefixes     = [cidrsubnet(var.base_vnet_cidr, 2, 3)]
  sn-service-end-point    = ["Microsoft.Storage"]
  depends_on              = [module.vnet, module.appsubnet]
}
#---------------------------------------
# Application Network Security Group
#---------------------------------------
module "app-nsg" {
  source            = "./modules/vnet/nsg"
  nsg-name          = upper("APP-${var.project}-${var.application_name}-${var.env}")
  nsg-location-name = module.ResourceGroup.rg-location
  nsg-rg-name       = module.ResourceGroup.rg-name
  nsg-tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = "APP-${var.project}-${var.application_name}-NSG"
    Type        = "Network Security Group"
    Company     = upper("${var.company_name}")
  }
  depends_on = [module.vnet, module.appsubnet]
}
#---------------------------------------
# Jumphost Network Security Group
#---------------------------------------
module "jump-nsg" {
  source            = "./modules/vnet/nsg"
  nsg-name          = upper("Jumphost-${var.project}-${var.application_name}-${var.env}")
  nsg-location-name = module.ResourceGroup.rg-location
  nsg-rg-name       = module.ResourceGroup.rg-name
  nsg-tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = "Nsg-Jumphost-${var.project}-${var.application_name}"
    Type        = "Network Security Group"
    Company     = upper("${var.company_name}")
  }
  depends_on = [module.vnet, module.jump-subnet]
}
#------------------------------------------------------------------------------
#  Application Network Security Group asscioation with Application Subnet 
#------------------------------------------------------------------------------
resource "azurerm_subnet_network_security_group_association" "appsubnet-asscioation-with-appnsg" {
  subnet_id                 = module.appsubnet.subnet-id
  network_security_group_id = module.app-nsg.nsg-id
}
#---------------------------------------------------------------------
# Jumphost Network Security Group asscioation with Jumphost  Subnet
#---------------------------------------------------------------------
resource "azurerm_subnet_network_security_group_association" "jumpsubnet-asscioation-with-jumpnsg" {
  subnet_id                 = module.jump-subnet.subnet-id
  network_security_group_id = module.jump-nsg.nsg-id
}
#---------------------------------------
# Application NSG Rules
#---------------------------------------
module "app-nsg-rules" {
  source                           = "./modules/vnet/nsg-rules"
  for_each                         = local.app-nsgrules
  nsgr-name                        = each.key
  nsgr-direction                   = each.value.direction
  nsgr-access                      = each.value.access
  nsgr-priority                    = each.value.priority
  nsgr-protocol                    = each.value.protocol
  nsgr-source_port_range           = each.value.source_port_range
  nsgr-destination_port_range      = each.value.destination_port_range
  nsgr-source_address_prefix       = each.value.source_address_prefix
  nsgr-destination_address_prefix  = each.value.destination_address_prefix
  nsgr-resource_group_name         = module.ResourceGroup.rg-name
  nsgr-network_security_group_name = module.app-nsg.nsg-name
}
#---------------------------------------
# Jumphost NSG Rules 
#---------------------------------------
module "jump-nsg-rules" {
  source                           = "./modules/vnet/nsg-rules"
  for_each                         = local.jump-nsgrules
  nsgr-name                        = each.key
  nsgr-direction                   = each.value.direction
  nsgr-access                      = each.value.access
  nsgr-priority                    = each.value.priority
  nsgr-protocol                    = each.value.protocol
  nsgr-source_port_range           = each.value.source_port_range
  nsgr-destination_port_range      = each.value.destination_port_range
  nsgr-source_address_prefix       = each.value.source_address_prefix
  nsgr-destination_address_prefix  = each.value.destination_address_prefix
  nsgr-resource_group_name         = module.ResourceGroup.rg-name
  nsgr-network_security_group_name = module.jump-nsg.nsg-name
}
#---------------------------------------
# Public Ip for Front end configuration
#---------------------------------------
resource "random_string" "fqdn" {
  length  = 6
  special = false
  upper   = false
  number  = false
}
resource "random_string" "fqdn-test" {
  length  = 6
  special = false
  upper   = false
  number  = false
}

module "public-ip" {
  source                  = "./modules/LoadBalancer/pip"
  pip_name                = upper("pip-${var.project}-${var.application_name}")
  pip_location            = module.ResourceGroup.rg-location
  pip_resource_group_name = module.ResourceGroup.rg-name
  pip_allocation_method   = var.allocation_method
  pip_sku                 = var.pip_sku
  pip_sku_tier            = var.pip_sku_tier
  pip_domain_name_label   = random_string.fqdn.result
  pip_tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = "PIP-FC-${var.project}-${var.application_name}-NSG"
    Type        = "Public IP"
    Company     = upper("${var.company_name}")
  }
}
#---------------------------------------
# Load Balancer
#---------------------------------------
module "lb" {
  source                 = "./modules/LoadBalancer"
  lb_name                = upper("LB-${var.project}-${var.application_name}")
  lb_location            = module.ResourceGroup.rg-location
  lb_resource_group_name = module.ResourceGroup.rg-name
  lb_sku                 = var.sku
  front-ip-config-name   = var.fipc-name
  public_ip_address_id   = module.public-ip.pip-id
  lb_tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = "LB-${var.project}-${var.application_name}"
    Type        = "Load Balancer"
    Company     = upper("${var.company_name}")
  }
}
#---------------------------------------
# Load Balancer backend pool
#---------------------------------------
module "lb-backend-pool" {
  source                     = "./modules/LoadBalancer/back-end-pool"
  azure-lb-id                = module.lb.LoadBalancerId
  back_end_pool_address_name = var.bepa-name
}
#---------------------------------------
# Load Balancer Health Probe
#---------------------------------------
module "lb-probe" {
  source            = "./modules/LoadBalancer/probe"
  probe-azure-lb-id = module.lb.LoadBalancerId
  probe_name        = var.probe-name
  probe_port        = var.probe-port-number
}
#---------------------------------------
# Load Balancer Rules
#---------------------------------------
module "lb-lb-rules" {
  source                                 = "./modules/LoadBalancer/lb-rules"
  lb-rule-name                           = var.lbr-name
  lb-rule-protocol                       = var.lbr-protocol
  lb-rule-bp                             = var.lbr-bp
  lb-rule-fp                             = var.lbr-fp
  lb-rule-frontend_ip_configuration_name = module.lb.FrontEndIpConfig
  lb-rule-backend_address_pool_ids       = [module.lb-backend-pool.BackendAddPoolID]
  lb-rule-probe_id                       = module.lb-probe.probe-id
  lb-rule-loadbalancer_id                = module.lb.LoadBalancerId
}
#---------------------------------------
# VM Scaleset
#---------------------------------------
module "vm-scale-set" {
  source                                    = "./modules/scale-set"
  vs_name                                   = upper("VMSS-${var.project}-${var.application_name}")
  vs_resource_group_name                    = module.ResourceGroup.rg-name
  vs_location                               = module.ResourceGroup.rg-location
  vs_sku                                    = var.vmss_sku
  vs_instance_count                         = var.vmss_instance_count
  vs_admin_username                         = var.admin_username
  vs_admin_password                         = var.admin_password
  vs_zones                                  = null
  vs_zone_balance                           = false
  vs_disable_password_authentication        = false
  vs_os_publisher                           = var.os_publisher
  vs_os_offer                               = var.os_offer
  vs_os_sku                                 = var.os_sku
  vs_os_version                             = var.os_version
  vs_os_disk_type                           = var.os_disk_type
  vs_os_disk_cashing                        = var.disk_cashing
  vs_os_disk_size-gb                        = var.os_disk_size-gb
  vs_data_lun                               = var.data_lun
  vs_data_disk_type                         = var.disk_type
  vs_data_disk_cashing                      = var.disk_cashing
  vs_data_disk_creation_type                = var.disk_creation_type
  vs_data_disk_size_gb                      = var.disk_size_gb
  vs_nic_name                               = upper("nic-${var.project}-${var.application_name}")
  vs_nic_primary                            = true
  vs_dns_servers                            = []
  vs_enable_ip_forwarding                   = false
  vs_enable_accelerated_networking          = false
  vs_nsg_id                                 = module.app-nsg.nsg-id
  vs_ip_cofig_name                          = upper("ip-${var.project}-${var.application_name}")
  vs_ip-config-primary                      = true
  vs_ip_config_subnet_id                    = module.appsubnet.subnet-id
  vs_load_balancer_backend_address_pool_ids = [module.lb-backend-pool.BackendAddPoolID]
  vm_tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = "VMSS-${var.project}-${var.application_name}"
    Type        = "VM SCALESET"
    Company     = upper("${var.company_name}")
  }

  // depends_on = [azapi_update_resource.patch]
}
#---------------------------------------
# Storage Account
#---------------------------------------
module "storage-account" {
  source                                    = "./modules/storage"
  sa-name                                   = lower("SA${var.project}${var.application_name}")
  sa-resource_group_name                    = module.ResourceGroup.rg-name
  sa-location                               = module.ResourceGroup.rg-location
  sa-account_kind                           = var.s-account_kind
  sa-account_tier                           = var.account_tier
  sa-account_replication_type               = var.account_replication_type
  sa-public_network_access_enabled          = true
  sa-container_delete_retention_policy-days = 7
  sa-delete_retention_policy-days           = 7
  sa-tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = "SA-${var.project}-${var.application_name}"
    Type        = upper("Storage-account")
    Company     = upper("${var.company_name}")
  }
}
#---------------------------------------
# Storage Account Net work rules
#---------------------------------------
resource "azurerm_storage_account_network_rules" "example" {
  default_action             = var.sanr-default_action
  storage_account_id         = module.storage-account.sa-id
  ip_rules                   = var.sanr-ip_rules
  virtual_network_subnet_ids = [module.appsubnet.subnet-id]
}
#---------------------------------------
# BLOB Container
#--------------------------------------
module "sac" {
  source                   = "./modules/storage/container"
  sac-name                 = lower("sc${var.project}${var.application_name}")
  sac-storage_account_name = module.storage-account.sa-name
}
#---------------------------------------
# JumpBox Public IP
#--------------------------------------
module "new-jump-host-public-ip" {
  source                  = "./modules/LoadBalancer/pip"
  pip_name                = upper("new-jump-pip-${var.project}-${var.application_name}")
  pip_location            = module.ResourceGroup.rg-location
  pip_resource_group_name = module.ResourceGroup.rg-name
  pip_allocation_method   = var.allocation_method
  pip_sku                 = var.pip_sku
  pip_sku_tier            = var.pip_sku_tier
  pip_domain_name_label   = "wgtfrk"
  pip_tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = "JUMP-${var.project}-${var.application_name}-NSG"
    Type        = "Public IP"
    Company     = upper("${var.company_name}")
  }
}
#---------------------------------------
# JumpBox NIC
#--------------------------------------
module "nic-jump-jumpbox" {
  source                            = "./modules/vnet/nic"
  nic-name                          = upper("nic-${var.project}-${var.application_name}")
  nic-location                      = module.ResourceGroup.rg-location
  nic-resource_group_name           = module.ResourceGroup.rg-name
  nic-ip-config-name                = var.jump-nic-ip-config
  nic-subnet_id                     = module.jump-subnet.subnet-id
  nic-private_ip_address_allocation = var.jump-nic-private_ip_address_allocation
  nic-public_ip_address_id          = module.new-jump-host-public-ip.pip-id
  nic-tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = "NIC-${var.project}-${var.application_name}"
    Type        = upper("NIC")
    Company     = upper("${var.company_name}")
  }
}
#---------------------------------------
# JumpBox Virtual machine
#--------------------------------------
module "jumpbox" {
  source                             = "./modules/vm"
  vm-name                            = upper("vm-jumpbox-${var.project}-${var.application_name}")
  vm-location                        = module.ResourceGroup.rg-location
  vm-resource_group_name             = module.ResourceGroup.rg-name
  vm-network_interface_ids           = [module.nic-jump-jumpbox.nic-id]
  vm-size                            = var.jb-vm-size
  vm-os-publisher                    = var.jb-vm-os-publisher
  vm-os-offer                        = var.jb-vm-os-offer
  vm-os-sku                          = var.jb-vm-os-sku
  vm-os-version                      = var.jb-vm-os-version
  vm-os-disk-name                    = upper("jumpbox-osdisk")
  vm-os-disk-caching                 = var.jb-os-disk-caching
  vm-os-disk-create_option           = var.jb-os-disk-create_option
  vm-os-disk-managed_disk_type       = var.jb-os-disk-managed-disk-type
  vm-os-p-computer_name              = upper("vm-jumpbox-${var.project}-${var.application_name}")
  vm-os-p-admin_username             = var.jb-os-p-admin_username
  vm-os-p-admin_password             = var.jb-os-p-admin_password
  vm-disable_password_authentication = false
  vm-tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = "VM-${var.project}-${var.application_name}"
    Type        = upper("Virtual Machine")
    Company     = upper("${var.company_name}")
  }
}
#---------------------------------------
# Private Dns Creation
#--------------------------------------
resource "azurerm_private_dns_zone" "default" {
  name                = lower("${var.project}psql-pdz.postgres.database.azure.com")
  resource_group_name = module.ResourceGroup.rg-name
  depends_on          = [azurerm_subnet_network_security_group_association.dbsubnet-asscioation-with-dbnsg]
  tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = upper("pdns-${var.project}-${var.application_name}")
    Type        = upper("Private-DNS")
    Company     = upper("${var.company_name}")
  }
   }
#---------------------------------------
# Private DNS asscioation with Vnet
#--------------------------------------
resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = lower("${var.project}psql-pdzvnetlink.com")
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = module.vnet.vnet-id
  resource_group_name   = module.ResourceGroup.rg-name
}
#---------------------------------------
# Db Password Generator
#--------------------------------------
resource "random_password" "db-pass" {
  length = 20
}
#---------------------------------------
# DB Subnet
#---------------------------------------
module "dbsubnet" {
  source                  = "./modules/vnet/subnets"
  sn-name                 = upper("Db-${var.project}-${var.application_name}-${var.env}")
  sn-resource_group_name  = module.ResourceGroup.rg-name
  sn-virtual_network_name = module.vnet.vnet-name
  sn-address_prefixes     = [cidrsubnet(var.base_vnet_cidr, 2, 1)]
  sn-service-end-point    = ["Microsoft.sql"]
  depends_on              = [module.vnet, module.appsubnet]
}
#---------------------------------------
# DB Network Security Group
#---------------------------------------
module "db-nsg" {
  source            = "./modules/vnet/nsg"
  nsg-name          = upper("Db-${var.project}-${var.application_name}-${var.env}")
  nsg-location-name = module.ResourceGroup.rg-location
  nsg-rg-name       = module.ResourceGroup.rg-name
  nsg-tags = {
    Project     = upper("${var.project}")
    Environment = upper("${var.env}")
    Application = upper("${var.application_name}")
    Name        = upper("Db-${var.project}-${var.application_name}-NSG")
    Type        = "Network Security Group"
    Company     = upper("${var.company_name}")
  }
}
#--------------------------------------------------------
# DB Network Security Group asscioation with DB  Subnet
#--------------------------------------------------------
resource "azurerm_subnet_network_security_group_association" "dbsubnet-asscioation-with-dbnsg" {
  subnet_id                 = module.dbsubnet.subnet-id
  network_security_group_id = module.db-nsg.nsg-id
}
#--------------------------------------------------------
# Adding the delegation rights DBsubnet
#--------------------------------------------------------
resource "azapi_update_resource" "patch" {
  type        = "Microsoft.Network/virtualNetworks/subnets@2022-05-01"
  resource_id = module.dbsubnet.subnet-id
  body = jsonencode({
    properties = {
      delegations = [
        {
          name = "db-delegation"
          properties = {
            serviceName = "Microsoft.DBforPostgreSQL/flexibleServers"
            actions     = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
          }
        }
      ]
    }
  })
}
#---------------------------------------
# Postgress Sql 
#--------------------------------------
module "psql" {
  source                            = "./modules/psql"
  psql-location                     = module.ResourceGroup.rg-location
  psql-resource_group_name          = module.ResourceGroup.rg-name
  psql-name                         = lower("Db-${var.project}-${var.application_name}-${var.env}")
  psql-sku_name                     = var.db-sku-name
  psql-version                      = var.db-psql-version
  psql-storage_mb                   = var.db-storage
  psql-backup_retention_days        = var.db-backup_retention_days
  psql-geo_redundant_backup_enabled = true
  psql-administrator_login          = var.db-administrator_login
  psql-administrator_password       = random_password.db-pass.result
  psql-delegated_subnet_id          = module.dbsubnet.subnet-id
  psql-private_dns_zone_id          = azurerm_private_dns_zone.default.id
  psql-tags = {
    Project     = upper("${var.project}")
    Environment = upper(var.env)
    Application = upper("${var.application_name}")
    Name        = "DB-${var.project}-${var.application_name}"
    Type        = "Psql"
    Company     = upper("${var.company_name}")
  }
  depends_on = [azurerm_private_dns_zone_virtual_network_link.default, azapi_update_resource.patch]
}
#---------------------------------------
# Postgress NSG Rules 
#--------------------------------------
module "db-nsg-rules" {
  source                           = "./modules/vnet/nsg-rules"
  for_each                         = local.db-nsgrules
  nsgr-name                        = each.key
  nsgr-direction                   = each.value.direction
  nsgr-access                      = each.value.access
  nsgr-priority                    = each.value.priority
  nsgr-protocol                    = each.value.protocol
  nsgr-source_port_range           = each.value.source_port_range
  nsgr-destination_port_range      = each.value.destination_port_range
  nsgr-source_address_prefix       = each.value.source_address_prefix
  nsgr-destination_address_prefix  = each.value.destination_address_prefix
  nsgr-resource_group_name         = module.ResourceGroup.rg-name
  nsgr-network_security_group_name = module.jump-nsg.nsg-name
}
