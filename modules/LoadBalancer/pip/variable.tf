variable "pip_name" {
  type = string
}
variable "pip_location" {
  type = string
}
variable "pip_resource_group_name" {
  type = string
}
variable "pip_allocation_method" {
  type = string
}
variable "pip_sku" {
  type = string
}
variable "pip_sku_tier" {
  type = string
}
variable "pip_domain_name_label" {
  type = string
}
variable "pip_tags" {
  type = map(any)
}