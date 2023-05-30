variable "vnet-name" {
  description = "Resource Group name"
  type        = string
}

variable "vnet-location" {
  type = string
}

variable "vnet-resource_group_name" {
  type = string
}

variable "vnet-cidr-range" {
  type = list(string)
}

variable "vnet-tags" {
  type = map(any)
}


