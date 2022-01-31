resource "azurerm_resource_group" "azure_rg" {
  name = local.rgname
  location = var.resource_group_location
  tags = local.common_tags
}