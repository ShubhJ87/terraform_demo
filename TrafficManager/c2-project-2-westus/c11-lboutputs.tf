output "web_lb_public_ip_address_id" {
  description = "Web Load Balancer Public Address Resource ID"
  value = azurerm_public_ip.web_server_lb_public_ip.id
}