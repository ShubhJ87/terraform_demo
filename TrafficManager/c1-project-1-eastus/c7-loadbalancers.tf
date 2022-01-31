resource "azurerm_lb" "web_server_lb" {
  name                = "${var.resource_prefix}-lb" 
  resource_group_name = azurerm_resource_group.azure_rg.name
  location            = azurerm_resource_group.azure_rg.location
   
  frontend_ip_configuration {
    name                 = "${var.resource_prefix}-lb-frontend-ip" 
    public_ip_address_id = azurerm_public_ip.web_lbpublicip.id
    
  }
}

resource "azurerm_lb_backend_address_pool" "web_server_lb_backend_pool" {
  name                = "${var.resource_prefix}-lb-backend-pool" 
  resource_group_name = azurerm_resource_group.azure_rg.name
  loadbalancer_id     = azurerm_lb.web_server_lb.id
}

resource "azurerm_lb_probe" "web_server_lb_http_probe" {
  name                = "${var.resource_prefix}-lb-http-probe" 
  resource_group_name = azurerm_resource_group.azure_rg.name
  loadbalancer_id     = azurerm_lb.web_server_lb.id
  protocol            = "tcp"
  port                = "80"
}

resource "azurerm_lb_rule" "web_server_lb_http_rule" {
  name                           = "${var.resource_prefix}-lb-http-rule" 
  resource_group_name            = azurerm_resource_group.azure_rg.name 
  loadbalancer_id                = azurerm_lb.web_server_lb.id  
  protocol                       = "tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
  frontend_ip_configuration_name = "${var.resource_prefix}-lb-frontend-ip"
  probe_id                       = azurerm_lb_probe.web_server_lb_http_probe.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.web_server_lb_backend_pool.id
}