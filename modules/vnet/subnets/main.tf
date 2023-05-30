resource "azurerm_subnet" "subnets" {
  name = upper("SN-${var.sn-name}")
  virtual_network_name = var.sn-virtual_network_name
  resource_group_name = var.sn-resource_group_name
  address_prefixes = var.sn-address_prefixes
  private_endpoint_network_policies_enabled = true
  service_endpoints = var.sn-service-end-point
}