terraform {
  required_version = ">=1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.43.0"
    }
  }
  cloud {
    organization = "accenture-workspace"
    workspaces {
      name = "remotestate"
    }
  }
}



provider "azurerm" {
  features {}
  skip_provider_registration = true
}

# Register the Microsoft.Storage resource provider
resource "azurerm_resource_provider_registration" "storage" {
  name = "Microsoft.Storage"
}

resource "azurerm_resource_group" "rg" {
  name     = "my-rg"
  location = "East US"
}

resource "azurerm_storage_account" "storage" {
  name                     = "vdterraformdemo01"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"

}
 
