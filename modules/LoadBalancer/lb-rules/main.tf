#-----------------------------------
# LB Rules
#-----------------------------------
resource "azurerm_lb_rule" "web_lb_rule_app1" {
  name                           = var.lb-rule-name
  protocol                       = var.lb-rule-protocol
  frontend_port                  = var.lb-rule-bp
  backend_port                   = var.lb-rule-fp
  frontend_ip_configuration_name = var.lb-rule-frontend_ip_configuration_name 
  backend_address_pool_ids       = var.lb-rule-backend_address_pool_ids
  probe_id                       = var.lb-rule-probe_id
  loadbalancer_id                = var.lb-rule-loadbalancer_id
}
