variable "vm-name" {
  type = string
}
variable "vm-location" {
  type = string
}
variable "vm-resource_group_name" {
  type = string
}
variable "vm-network_interface_ids" {
  type = list(string)
}
variable "vm-size" {
  type = string
}
variable "vm-os-publisher" {
  type = string
}
variable "vm-os-offer" {
  type = string
}
variable "vm-os-sku" {
  type = string
}
variable "vm-os-version" {
  type = string
}

variable "vm-os-disk-name" {
  type = string
}
variable "vm-os-disk-caching" {
  type = string
}
variable "vm-os-disk-create_option" {
  type = string
}
variable "vm-os-disk-managed_disk_type" {
  type = string
}

variable "vm-os-p-computer_name" {
  type = string
}
variable "vm-os-p-admin_username" {
  type = string
}
variable "vm-os-p-admin_password" {
  type = string
}
variable "vm-disable_password_authentication" {
  type = string
}
variable "vm-tags" {

}
