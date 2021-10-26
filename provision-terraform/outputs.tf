output "webapp_url" {
    value = azurerm_app_service.appinsightdemo.default_site_hostname
}

output "webapp_ips" {
    value = azurerm_app_service.appinsightdemo.outbound_ip_addresses
}