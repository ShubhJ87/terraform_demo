resource "azurerm_resource_group" "azrg" {
    name = local.rgname
    location = var.resource_group_location
}


