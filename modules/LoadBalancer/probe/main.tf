resource "azurerm_lb_probe" "vmss-probe" {
  loadbalancer_id = var.probe-azure-lb-id
  name            = var.probe_name
  port            = var.probe_port
}