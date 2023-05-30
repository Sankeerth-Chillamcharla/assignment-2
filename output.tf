output "rg-name" {
  value = module.ResourceGroup.rg-name
}
output "rg-location" {
  value = module.ResourceGroup.rg-location
}
output "vnet-name" {
  value = module.vnet.vnet-name
}
output "vnet-address" {
  value = module.vnet.vnet-address
}

output "lb-name" {
  value = module.lb.LoadBalancer-name
}

output "vmss-name" {
  value = module.vm-scale-set.nmss-name
}

output "sn-name" {
  value = module.storage-account.sa-name
}
output "sac-name" {
  value = module.sac.sac-name
}
output "db-name" {
  value = module.psql.db-name
}

output "vm-name" {
  value = module.jumpbox.vm-name
}

output "lb-ip" {
  value = module.public-ip.pip-ip
}

output "jump-ip" {
  value = module.new-jump-host-public-ip.pip-ip
}
