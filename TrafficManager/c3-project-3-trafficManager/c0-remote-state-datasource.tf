#Project-1 East Us
data "terraform_remote_state" "project1_eastus2"{
    backend = "azurerm"
    config ={
        resource_group_name = "DevopsRG"
        storage_account_name = "devopsengb"
        container_name = "tfstatefiles"
        key = "c1-project-1-eastus-terraform.tfstate"
    }
}

#Project-2 : West Us
data "terraform_remote_state" "project2_westus2"{
    backend = "azurerm"
    config = {
        resource_group_name = "DevopsRG"
        storage_account_name = "devopsengb"
        container_name = "tfstatefiles"
        key = "c2-project-2-westus-terraform.tfstate"
    }
}