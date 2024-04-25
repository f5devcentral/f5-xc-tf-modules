locals {
  vip_info_vip_params_per_az = [
    for node in var.f5xc_azure_az_nodes :
    {
      az      = node["az"]
      slo_vip = azurerm_lb.lb.frontend_ip_configuration[0].private_ip_address
      sli_vip = azurerm_lb.lb.frontend_ip_configuration[1].private_ip_address
    }
  ]
}

