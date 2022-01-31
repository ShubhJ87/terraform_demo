terraform {
    required_version = ">=1.0.0"
    required_providers {
        azurerm = { 
            source ="hashicorp/azurerm"
            version =">=2.0.0"
        }
        random = {
            source = "hashicorp/random"
            version =">=3.0"
        }
        null = {
            source = "hashicorp/null"
            version =">=3.0"
        }
    }
    # Terraform State Storage to Azure Storage Container
  backend "azurerm" {
       resource_group_name = "DevopsRG"
        storage_account_name = "devopsengb"
        container_name = "tfstatefiles"
        key            = "project-3-trafficManager-terraform.tfstate"
  }  
}


provider "azurerm" {
    features{}
}