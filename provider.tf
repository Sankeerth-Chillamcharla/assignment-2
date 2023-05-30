terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.57.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "=0.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-XYZ-CROP-TERRAFORM"
    storage_account_name = "<storage account name>"
    container_name       = "tfstatefile"
    key                  = "terraform.tfstate"
  }

}
provider "azapi" {
}
provider "azurerm" {
  subscription_id = "<azure_subscription_id>"
  tenant_id       = "<azure_subscription_tenant_id>"
  client_id       = "<service_principal_appid>"
  client_secret   = "<service_principal_password>"
  features {}
}
