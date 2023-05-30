#-----------------------------------
# Load Balancer
#-----------------------------------
resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.lb_location
  resource_group_name = var.lb_resource_group_name
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = var.front-ip-config-name
    public_ip_address_id = var.public_ip_address_id
  }
  tags = var.lb_tags
}


