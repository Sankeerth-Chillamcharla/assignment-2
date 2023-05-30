variable "lb-rule-name" {
  type = string
}
variable "lb-rule-protocol" {
  type = string
}
variable "lb-rule-fp" {
  type = string
}
variable "lb-rule-bp" {
  type = string
}
variable "lb-rule-frontend_ip_configuration_name" {
  type = string
}
variable "lb-rule-backend_address_pool_ids" {
  type = list(string)
}
variable "lb-rule-probe_id" {
  type = string
}
variable "lb-rule-loadbalancer_id" {
  type = string
}
