output "common" {
  value = {
    lb                       = azurerm_lb.lb
    azurerm_lb_rule_slo      = azurerm_lb_rule.slo
    azurerm_lb_rule_sli      = var.is_multi_nic ? azurerm_lb_rule.sli.0 : null
    backend_address_pool_slo = azurerm_lb_backend_address_pool.slo
    backend_address_pool_sli = var.is_multi_nic ? azurerm_lb_backend_address_pool.sli.0 : null
  }
}