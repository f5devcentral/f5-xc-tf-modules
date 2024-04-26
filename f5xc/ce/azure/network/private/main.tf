resource "azurerm_public_ip_prefix" "pipp" {
  name                = format("%s-private-ce-pipp", var.f5xc_cluster_name)
  sku                 = "Standard"
  location            = var.azurerm_region
  ip_version          = "IPv4"
  prefix_length       = var.azurerm_public_ip_prefix_prefix_length
  allocation_method   = var.azurerm_public_ip_allocation_method
  resource_group_name = var.azurerm_resource_group_name
}

resource "azurerm_nat_gateway" "gw" {
  name                    = format("%s-private-ce-nat-gw", var.f5xc_cluster_name)
  zones                   = var.azurerm_zones
  location                = var.azurerm_resource_group_name
  sku_name                = "Standard"
  resource_group_name     = var.azurerm_region
  idle_timeout_in_minutes = var.azurerm_nat_gateway_idle_timeout_in_minutes
}

resource "azurerm_nat_gateway_public_ip_association" "gw_to_pip" {
  nat_gateway_id       = azurerm_nat_gateway.gw.id
  public_ip_address_id = azurerm_public_ip_prefix.pipp.id
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "nat_gw_to_pipp" {
  nat_gateway_id      = azurerm_nat_gateway.gw.id
  public_ip_prefix_id = azurerm_public_ip_prefix.pipp.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_to_nat_gw" {
  count          = length(var.azurerm_nat_gateway_subnet_ids)
  subnet_id      = var.azurerm_nat_gateway_subnet_ids[count.index]
  nat_gateway_id = azurerm_nat_gateway.gw.id
}