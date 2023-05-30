resource "azurerm_lb_backend_address_pool" "back-end-pool" {
  loadbalancer_id = var.azure-lb-id
  name            = var.back_end_pool_address_name
}