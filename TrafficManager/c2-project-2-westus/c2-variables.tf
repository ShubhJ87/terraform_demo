variable "resource_group_name" {
    description = "Name of Resource Group Name"
    type = string
    default = "azurecosmos"
}

variable "resource_group_location" {
description = "Resource Group Location"
type =string 
default = "EastUs2"  
}

variable "Environment" {
    description = "Enivornment"
    type = string
    default = "qa"
  
}

variable "business_unit" {
    type = string
    description = "Business Unit"
    default = "it"
  
}
