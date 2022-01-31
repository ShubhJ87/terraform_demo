resource "azurerm_storage_account" "azure_storage" {
  name = "${var.storage_account_name}"
  resource_group_name = azurerm_resource_group.azrg.name
  location = var.resource_group_location

  account_tier = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind = var.storage_account_kind

  static_website {
    index_document = var.static_website_index_document
    error_404_document = var.static_website_error_404_document
  }
}