variable "project" {
  description = "Project Name"
  type        = string
}
variable "application_name" {
  type = string
}
variable "env" {
  type = string
}
variable "company_name" {
  type = string
}
variable "location" {
  description = "Location"
  type        = string
}
variable "vnet-map" {
  description = "Net Work CIDIR Range"
  type        = list(string)
}
variable "base_vnet_cidr" {
  description = "Net Work CIDIR Range"
  type        = string
}
variable "vmss_sku" {
  type = string
}
variable "vmss_instance_count" {
  type = string
}
variable "admin_username" {
  type = string
}
variable "admin_password" {
  type = string
}
variable "os_publisher" {
  type = string
}
variable "os_offer" {
  type = string
}

variable "os_sku" {
  type = string
}

variable "os_version" {
  type = string
}
variable "disk_type" {
  type = string
}
variable "disk_cashing" {
  type = string
}
variable "os_disk_size-gb" {
  type = string
}
variable "data_lun" {
  type = string
}
variable "disk_size_gb" {
  type = string
}
variable "os_disk_type" {
  type = string
}
variable "os_disk_data_caching" {
  type = string
}
variable "disk_creation_type" {
  type = string
}
variable "account_kind" {
  description = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  default     = "StorageV2"
  type        = string
}
#---------------------------------------
# Load Balancer variables
#---------------------------------------
variable "allocation_method" {
  type = string
}
variable "pip_sku" {
  type = string
}
variable "pip_sku_tier" {
  type = string
}
variable "sku" {
  type = string
}
variable "fipc-name" {
  type = string
}
variable "bepa-name" {
  type = string
}
variable "probe-name" {
  type = string
}
variable "probe-port-number" {
  type = string
}
variable "lbr-name" {
  type = string
}
variable "lbr-protocol" {
  type = string
}
variable "lbr-bp" {
  type = string
}
variable "lbr-fp" {
  type = string
}
#---------------------------------------
# Storage variables
#---------------------------------------
variable "s-account_kind" {
  type = string
}
variable "account_tier" {
  type = string
}
variable "account_replication_type" {
  type = string
}

variable "sanr-default_action" {
  type = string
}
variable "sanr-ip_rules" {
  type = list(string)
}
#---------------------------------------
# psql variables
#---------------------------------------
variable "db-sku-name" {
  type = string
}

variable "db-psql-version" {
  type = string
}

variable "db-storage" {
  type = string
}

variable "db-backup_retention_days" {
  type = string
}

variable "db-administrator_login" {
  type = string
}
#---------------------------------------
# JumpBox Variables 
#---------------------------------------

variable "jb-vm-size" {
  type = string
}
variable "jb-vm-os-publisher" {
  type = string
}
variable "jb-vm-os-offer" {
  type = string
}
variable "jb-vm-os-sku" {
  type = string
}
variable "jb-vm-os-version" {
  type = string
}
variable "jb-os-disk-caching" {
  type = string
}
variable "jb-os-disk-create_option" {
  type = string
}
variable "jb-os-disk-managed-disk-type" {
  type = string
}
variable "jb-os-p-admin_username" {
  type = string
}
variable "jump-nic-ip-config" {
  type = string
}
variable "jump-nic-private_ip_address_allocation" {
  type = string
}
variable "jb-os-p-admin_password   " {
  type = string
}















