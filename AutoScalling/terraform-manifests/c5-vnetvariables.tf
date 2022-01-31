variable "virtual_network_name" {
  type = string
  description = "Virtual Network Name"
  default = "AzureVnet"
}

variable "vnet_address_space" {
    type = list(string)
    description = "virtual Network Address Space"
    default = ["1.0.0.0/22"]
}

variable "web_server_subnets" {
  type= string
  description = "Virtual Network Subnet"
  default = "AzureSubnet"
}


variable "vnet_subnet_address_prefix" {
  type = list(string)
  description = "(optional) describe your variable"
  default = ["1.0.1.0/24"]
}

variable "webserver_nsg_name" {
type = string
description = "Network security name" 
default = "Azure_NSG"
}

variable "Public_Ip_Name"{
  type = string
  description = "Public IP for Azure VM"
  default = "Azure_Public_IP"
}

variable "Public_IP_Allocation_Type"{
  type = string
  description = "Allocation"
  default = "Static"
}

variable "vnet_nic" {
  type = string 
  description = "Network Interface"
  default = "Azure_NIC"
}

variable "azure_vm_name"{
  type = string
  description = "Name of Windows VM"
  default = "CosmosVM"
}

variable "azure_vm_size" {
type = string 
description = "Azure_VM_Size"
default = "Standard_B1s"  
}

variable "azure_vm_caching_type" {
  type = string
  description = "Caching Type"
  default = "ReadWrite"  
}

variable "azure_vm_storage_account_type"{
  type = string
  description = "Azure storage account type"
  default = "Standard_LRS"
}

variable "azure_vm_image_publisher"{
  type = string 
  description = "Azure VM Image Publisher"
  default = "MicrosoftWindowsServer"
}

variable "azure_vm_image_offer"{
  type = string 
  description = "Azure storage Image"
  default = "WindowsServer"
}

variable "azure_vm_image_sku"{
  type = string 
  description = "value"
  default = "2019-Datacenter"
}

variable "azure_vm_image_version"{
  type = string 
  description = "value"
  default = "latest"
}

variable "azure_vm_username" {
  type = string 
  description = "Azure VM UserName"
  default = "Cosmos_admin"
  sensitive = true 
}

variable "azure_vm_password" {
  type = string 
  description = "Azure VM Password"
  default = "CosmosAdmin@123"
  sensitive = true 
}

variable "azure_vm_extension"{
  type = string
  description = "Azure VM Extension"
  default = "Cosmos_Azure_VM_Extension"
}

variable "azure_lb_name" {
  type = string 
  description = "Azure VM Password"
  default = "Cosmos_Load_Balancer"
  //sensitive = true 
}

variable "azure_lb_publicIp"{
  type = string 
  description = "Azure Load Balancer Public Ip"
  default = "Cosmos_Load_Balancer_PublicIP"
}


variable "azure_storage"{
    type = string 
    description = "azure storage account"
    default = "azstrg"
}

variable "resource_prefix"{
    type = string 
    description = "default"
    default = "azure"
}

variable "web_server_count" {
    type = string
    description = "(optional) describe your variable"
}

variable "web_server_name" {
    type = string
    description = "(optional) describe your variable"
}