project          = "15Five"
application_name = "Webapp"
env              = "prod"
company_name     = "xyz crop"
location         = "West Europe"
#---------------------------------------
# Virutal Network CIDR Range
#---------------------------------------
vnet-map       = ["10.17.0.0/24"]
base_vnet_cidr = "10.17.0.0/24"
#---------------------------------------
# VM scaleset Inputs 
#---------------------------------------
# NOTE: Make sure change the vmscale set input deatils are properly other wise, it may impct the whole scale set 
#-------- Instance details -------------
vmss_sku     = "Standard_B1s"
os_publisher = "Canonical"
os_offer     = "UbuntuServer"
os_sku       = "18.04-LTS"
os_version   = "latest"
#-------- Number of Instance -------------
vmss_instance_count = "2"
#-------- Administrator deatils -------------
admin_username = "san-admin"
admin_password = "asd@123456789" # NOTE: Exposing the credentials is not recommended method.
#--------  Os Disk deatils -------------
os_disk_size-gb      = null
os_disk_type         = "StandardSSD_LRS"
os_disk_data_caching = "ReadWrite"
#--------  Peresistance Data Disk deatils -------------
data_lun           = "0"
disk_type          = "StandardSSD_LRS"
disk_cashing       = "ReadWrite"
disk_size_gb       = "100"
disk_creation_type = "Empty"
#---------------------------------------
# Load Balancer Inputs 
#---------------------------------------
# ------- Public IP ---------------
allocation_method = "Static"
pip_sku           = "Standard"
pip_sku_tier      = "Regional"
# ----- LB ---------
sku               = "Standard"
fipc-name         = "PublicIpAddress"
bepa-name         = "BackEndAddressPool"
probe-name        = "Http-running-probe"
probe-port-number = "80"
lbr-name          = "web-app-rule"
lbr-bp            = "80"
lbr-protocol      = "Tcp"
lbr-fp            = "80"
#---------------------------------------
# Storage account Inputs 
#---------------------------------------
s-account_kind           = "StorageV2"
account_tier             = "Standard"
account_replication_type = "GRS"
sanr-default_action      = "Deny"
sanr-ip_rules            = ["122.169.142.99"]  # To access the storage account we need to our public ip  
#---------------------------------------
# Psql Inputs 
#---------------------------------------
db-sku-name              = "B_Standard_B1ms"
db-administrator_login   = "dbadmin"
db-backup_retention_days = "7"
db-psql-version          = "14"
db-storage               = "32768"
#---------------------------------------
# JumpBox Inputs 
#---------------------------------------
jb-vm-size                             = "Standard_B1s"
jb-vm-os-publisher                     = "Canonical"
jb-vm-os-offer                         = "UbuntuServer"
jb-vm-os-sku                           = "18.04-LTS"
jb-vm-os-version                       = "latest"
jb-os-disk-caching                     = "ReadWrite"
jb-os-disk-create_option               = "FromImage"
jb-os-disk-managed-disk-type           = "Standard_LRS"
jb-os-p-admin_username                 = "san-admin"
jb-os-p-admin_password                 = "asd@123456789" # NOTE: Exposing the credentials is not recommended method.
jump-nic-ip-config                     = "internal"
jump-nic-private_ip_address_allocation = "Dynamic"
