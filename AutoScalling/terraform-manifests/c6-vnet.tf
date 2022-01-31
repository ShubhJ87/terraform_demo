resource "azurerm_virtual_network" "azure_vnet"{
    name = "${var.virtual_network_name}"
    resource_group_name = azurerm_resource_group.azure_rg.name
    location = azurerm_resource_group.azure_rg.location
    address_space = "${var.vnet_address_space}"
}

resource "azurerm_subnet" "web_server_subnet" {
    //for_each = var.web_server_subnets
    name = "${var.web_server_subnets}"
    //name  = each.key
    resource_group_name = azurerm_resource_group.azure_rg.name
    virtual_network_name = azurerm_virtual_network.azure_vnet.name 
    address_prefixes = "${var.vnet_subnet_address_prefix}"
    
}

resource "azurerm_public_ip" "web_server_lb_public_ip" {
  name                = "${var.resource_prefix}-public-ip"
  location            = azurerm_resource_group.azure_rg.location
  resource_group_name = azurerm_resource_group.azure_rg.name  
  allocation_method   = var.Public_IP_Allocation_Type
}

resource "azurerm_network_security_group" "web_server_nsg" {
    name = "${var.webserver_nsg_name}"
    location = azurerm_resource_group.azure_rg.location
    resource_group_name = azurerm_resource_group.azure_rg.name 
  
}

resource "azurerm_network_security_rule" "web_server_nsg_rule_rdp" {
  name                        = "RDP Inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.azure_rg.name  
  network_security_group_name = azurerm_network_security_group.web_server_nsg.name
  //count = var.environment     == "production" ? 0 : 1
}

resource "azurerm_network_security_rule" "web_server_nsg_rule_http" {
  name                        = "HTTP Inbound"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.azure_rg.name  
  network_security_group_name = azurerm_network_security_group.web_server_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "web_server_sag" {
    subnet_id = azurerm_subnet.web_server_subnet.id
    network_security_group_id = azurerm_network_security_group.web_server_nsg.id
}

resource "azurerm_storage_account" "storage_account"{
    name = "${var.azure_storage}"
    location = azurerm_resource_group.azure_rg.location
    resource_group_name = azurerm_resource_group.azure_rg.name
    account_tier = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_virtual_machine_scale_set" "scale_set" {
  name = "${var.resource_prefix}-scale-set"
  location = azurerm_resource_group.azure_rg.location
  resource_group_name = azurerm_resource_group.azure_rg.name
  upgrade_policy_mode = "Manual"

   sku {
    name     = "Standard_B1s"
    tier     = "Standard"
    capacity =  "${var.web_server_count}"
  }

  storage_profile_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServerSemiAnnual"
    sku       = "Datacenter-Core-1709-smalldisk"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name_prefix = "${var.web_server_name}"
    admin_username       = "webserver"
    admin_password       =  "admin@123"
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }

  network_profile {
    name    = "web_server_network_profile"
    primary = true

    ip_configuration {
      name                                   = "${var.web_server_name}"
      primary                                = true
      subnet_id                              = azurerm_subnet.web_server_subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_server_lb_backend_pool.id]
    }
  }

  //boot_diagnostics {
    //enabled     = true
    //storage_uri = azurerm_storage_account.storage_account.primary_blob_endpoint
  //}

  extension {
      name                 = "${var.web_server_name}-extension"
      publisher            = "Microsoft.Compute"
      type                 = "CustomScriptExtension"
      type_handler_version = "1.10"

      settings = <<SETTINGS
      {
        "fileUris": ["https://raw.githubusercontent.com/eltimmo/learning/master/azureInstallWebServer.ps1"],
        "commandToExecute": "start powershell -ExecutionPolicy Unrestricted -File azureInstallWebServer.ps1"
      }
      SETTINGS

  }
}