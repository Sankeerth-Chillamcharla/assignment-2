
variable "vs_name" {
  type = string
}

variable "vs_resource_group_name" {
  type = string
}
variable "vs_location" {
  type = string
}

variable "vs_sku" {
  type = string
}

variable "vs_instance_count" {
  type = string
}

variable "vs_admin_username" {
  type = string
}

variable "vs_admin_password" {
  type = string
}

variable "vs_os_publisher" {
  type = string
}

variable "vs_os_offer" {
  type = string
}

variable "vs_os_sku" {
  type = string
}

variable "vs_os_version" {
  type = string
}


variable "vs_data_disk_type" {
  type = string
}

variable "vs_data_disk_cashing" {
  type = string
}

variable "vs_os_disk_size-gb" {
  type = string
}

variable "vs_data_lun" {
  type = string
}

variable "vs_data_disk_size_gb" {
  type = string
}

variable "vs_os_disk_type" {
  type = string
}

# variable "vs_os_disk_caching" {
#   type = string
# }

# variable "vs_disk_creation_type" {
#   type = string
# }


variable "vs_nic_name" {
  type = string
}

variable "vs_nsg_id" {
  type = string
}

variable "vs_ip_cofig_name" {
  type = string
}


# variable "vs_subnet_id" {
#   type = string
# }

variable "vs_load_balancer_backend_address_pool_ids" {
  type = list(string)
}

variable "vs_zones" {

}
variable "vs_zone_balance" {
  type = string
}

variable "vs_disable_password_authentication" {
  type = bool
}

variable "vs_nic_primary" {
  type = bool
}
variable "vs_dns_servers" {
  type = list(string)
}


variable "vs_enable_ip_forwarding" {
  type = bool
}

variable "vs_enable_accelerated_networking" {
  type = bool
}


variable "vs_ip-config-primary" {
  type = bool
}



variable "vs_ip_config_subnet_id" {
  type = string
}


variable "vs_data_disk_creation_type" {
  type = string
}


variable "vs_os_disk_cashing" {
  type = string
}


variable "vm_tags" {

}
