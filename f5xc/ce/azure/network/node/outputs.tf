output "ce" {
  value = {
    slo           = azurerm_network_interface.slo
    sli           = var.is_multi_nic ? azurerm_network_interface.sli : null
    rt_sli        = var.is_multi_nic ? azurerm_route_table.sli : null
    public_ip     = azurerm_public_ip.ip
    slo_subnet    = var.azurerm_existing_subnet_name_slo == null ? azurerm_subnet.slo.0 : data.azurerm_subnet.slo.0
    sli_subnet    = var.is_multi_nic && var.azurerm_existing_subnet_name_sli == null ? azurerm_subnet.sli.0 : data.azurerm_subnet.sli.0
    interface_ids = local.interface_ids
  }
}