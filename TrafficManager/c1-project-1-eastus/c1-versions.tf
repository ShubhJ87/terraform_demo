terraform {
    required_version = ">=1.0.0"
    required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = ">2.2.0"
      }
    }
    backend "azurerm"{
        resource_group_name = "DevopsRG"
        storage_account_name = "devopsengb"
        container_name = "tfstatefiles"
        key = "c1-project-1-eastus-terraform.tfstate"
    }
}

provider "azurerm" {
    features {}
  
}