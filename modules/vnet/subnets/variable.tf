variable "sn-name" {
    type = string
}

variable "sn-virtual_network_name" {
    type = string
}
variable "sn-address_prefixes" {
  type = list(string)
}

variable "sn-resource_group_name" {
  type = string
}

variable "sn-service-end-point" {
  type = list(string)
}
