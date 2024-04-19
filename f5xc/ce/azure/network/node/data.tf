data "azurerm_subnet" "slo" {
  count                = var.azurerm_existing_subnet_name_slo != "" ? 1 : 0
  name                 = var.azurerm_existing_subnet_name_slo
  virtual_network_name = var.azurerm_vnet_name
  resource_group_name  = var.azurerm_resource_group_name
}

data "azurerm_subnet" "sli" {
  count                = var.is_multi_nic && var.azurerm_existing_subnet_name_sli != "" ? 1 : 0
  name                 = var.azurerm_existing_subnet_name_sli
  virtual_network_name = var.azurerm_vnet_name
  resource_group_name  = var.azurerm_resource_group_name
}