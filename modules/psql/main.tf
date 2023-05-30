resource "random_password" "db-pass" {
  length = 20
}
resource "azurerm_postgresql_flexible_server" "psql" {
  location                     = var.psql-location
  resource_group_name          = var.psql-resource_group_name
  name                         = var.psql-name
  sku_name                     = var.psql-sku_name
  version                      = var.psql-version
  storage_mb                   = var.psql-storage_mb
  backup_retention_days        = var.psql-backup_retention_days
  geo_redundant_backup_enabled = var.psql-geo_redundant_backup_enabled
  administrator_login          = var.psql-administrator_login
  administrator_password       = var.psql-administrator_password
  delegated_subnet_id          = var.psql-delegated_subnet_id
  tags                         = var.psql-tags
  private_dns_zone_id          = var.psql-private_dns_zone_id
}


