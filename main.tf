terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.43.0"
    }
  }
  cloud {
    organization = "accenture-workspace"
    workspaces {
      name = "TerraformCI"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  # subscription_id = "80ea84e8-afce-4851-928a-9e2219724c69"
  # client_id       = "f9eb9499-49b8-46c8-bade-8a3810811801"
  # client_secret   = "g0p8Q~Ems2Ij~cCousLAqpR.rKWII-N-BHCLtaEd"
  # tenant_id       = "84f1e4ea-8554-43e1-8709-f0b8589ea118"
}

resource "random_string" "uniquestring" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "811-bb689e08-provide-continuous-delivery-with-gith"
  location = "West US"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "stg${random_string.uniquestring.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
