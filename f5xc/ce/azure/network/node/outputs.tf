output "ce" {
  value = {
    slo           = azurerm_network_interface.slo
    sli           = var.is_multi_nic ? azurerm_network_interface.sli : null
    rt_sli        = var.is_multi_nic ? azurerm_route_table.sli : null
    public_ip     = azurerm_public_ip.ip
    slo_subnet    = var.azurerm_subnet_slo_address_prefix != "" ? azurerm_subnet.slo : null
    sli_subnet    = var.is_multi_nic && var.azurerm_subnet_sli_address_prefix != "" ? azurerm_subnet.sli : null
    interface_ids = local.interface_ids
  }
}