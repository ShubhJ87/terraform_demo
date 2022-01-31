variable "resource_group_name" {
    type = string
    description = "Name of Resource group"
    default = "Azrg"
}

variable "resource_group_location" {
    type = string
    description = "Location of resource group"
    default = "eastus2" 
}

variable "business_group" {
  type = string
  description = "Business Group"
  default = "0365"
}

variable "random_prefix" {
    type =string
    description = "Random Prefix"
    default = "azure-" 
}

variable "storage_account_tier" {
  type = string
  description = "storage_account_tier" 
}

variable "storage_account_replication_type" {
type = string
description = "storage account replication type" 
}

variable "storage_account_kind" {
type = string
description = "storage account kind" 
}

variable "static_website_index_document" {
type = string
description = "static website index document" 
}

variable "static_website_error_404_document" {
type = string
description = "static website error 404 document" 
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}