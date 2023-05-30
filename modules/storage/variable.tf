variable "sa-name" {
  type = string
}


variable "sa-resource_group_name" {
  type = string
}

variable "sa-location" {
  type = string
}


variable "sa-account_kind" {
  type = string
}

variable "sa-account_tier" {
  type = string
}

variable "sa-account_replication_type" {
  type = string
}

variable "sa-public_network_access_enabled" {
  type = string
}

variable "sa-delete_retention_policy-days" {
  type = number
}

variable "sa-container_delete_retention_policy-days" {
  type = number
}

variable "sa-tags" {
}
