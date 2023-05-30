output "LoadBalancer-name" {
  value = azurerm_lb.lb.name  
}
output "LoadBalancerId" {
  value = azurerm_lb.lb.id
}
output "FrontEndIpConfig" {
  value = azurerm_lb.lb.frontend_ip_configuration[0].name
}