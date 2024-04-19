data "azurerm_subnet" "slo" {
  name                 = "backend"
  virtual_network_name = var.azurerm_vnet_name
  resource_group_name  = var.azurerm_resource_group_name
}

data "azurerm_subnet" "sli" {
  name                 = "backend"
  virtual_network_name = var.azurerm_vnet_name
  resource_group_name  = var.azurerm_resource_group_name
}