resource "volterra_token" "site" {
  name      = var.f5xc_token_name != "" ? var.f5xc_token_name : var.f5xc_cluster_name
  namespace = var.f5xc_namespace
}

resource "azurerm_resource_group" "rg" {
  count    = var.azurerm_existing_resource_group_name != "" ? 0 : 1
  name     = format("%s-rg", var.f5xc_cluster_name)
  location = var.azurerm_region
}

module "ce_default_security_rules" {
  source                         = "./network/sgr"
  azure_security_group_rules_slo = local.azure_security_group_rules_slo_default
}

module "maurice" {
  source       = "../../../../utils/maurice"
  f5xc_api_url = var.f5xc_api_url
}

module "network_common" {
  source                        = "./network/common"
  common_tags                   = local.common_tags
  azurerm_region                = var.azurerm_region
  f5xc_cluster_name             = var.f5xc_cluster_name
  azurerm_vnet_address_space    = var.azurerm_vnet_address_space
  azurerm_existing_vnet_name    = var.azurerm_existing_vnet_name
  azurerm_resource_group_name   = local.f5xc_azure_resource_group
  azurerm_security_group_slo_id = length(var.azurerm_security_group_rules_slo) > 0 ? var.azurerm_security_group_rules_slo : module.ce_default_security_rules.sgr["security_group_rules_slo"]
}

module "network_master_node" {
  source                            = "./network/node"
  for_each                          = {for k, v in var.f5xc_cluster_nodes.master : k => v}
  has_public_ip                     = var.has_public_ip
  f5xc_node_name                    = format("%s-%s", var.f5xc_cluster_name, each.key)
  azurerm_zone                      = var.azurerm_availability_set_id == "" ? each.value["az"] : ""
  azurerm_region                    = var.azurerm_region
  azurerm_vnet_name                 = module.network_common.common["vnet"]["name"]
  azurerm_resource_group_name       = local.f5xc_azure_resource_group
  azurerm_security_group_slo_id     = module.network_common.common["sg_slo"]["id"]
  azurerm_existing_subnet_name_slo  = contains(keys(var.f5xc_cluster_nodes[each.key]), "existing_subnet_name_slo") ? each.value["existing_subnet_name_slo"] : null
  azurerm_route_table_next_hop_type = var.azurerm_route_table_next_hop_type
  azurerm_subnet_slo_address_prefix = contains(keys(each.value), "subnet_slo") ? each.value["subnet_slo"] : ""
}

module "network_worker_node" {
  source                            = "./network/node"
  for_each                          = {for k, v in var.f5xc_cluster_nodes.worker : k => v}
  has_public_ip                     = var.has_public_ip
  f5xc_node_name                    = format("%s-%s", var.f5xc_cluster_name, each.key)
  azurerm_zone                      = var.azurerm_availability_set_id == "" ? each.value["az"] : ""
  azurerm_region                    = var.azurerm_region
  azurerm_vnet_name                 = module.network_common.common["vnet"]["name"]
  azurerm_resource_group_name       = local.f5xc_azure_resource_group
  azurerm_security_group_slo_id     = module.network_common.common["sg_slo"]["id"]
  azurerm_existing_subnet_name_slo  = contains(keys(var.f5xc_cluster_nodes[each.key]), "existing_subnet_name_slo") ? each.value["existing_subnet_name_slo"] : null
  azurerm_route_table_next_hop_type = var.azurerm_route_table_next_hop_type
  azurerm_subnet_slo_address_prefix = contains(keys(each.value), "subnet_slo") ? each.value["subnet_slo"] : ""
}

module "site_wait_for_online_worker" {
  depends_on                 = [module.node_worker]
  source                     = "../../../status/site"
  is_sensitive               = var.is_sensitive
  f5xc_tenant                = var.f5xc_tenant
  f5xc_api_url               = var.f5xc_api_url
  f5xc_api_token             = var.f5xc_api_token
  f5xc_namespace             = var.f5xc_namespace
  f5xc_site_name             = var.f5xc_cluster_name
  f5xc_api_p12_file          = var.f5xc_api_p12_file
  status_check_type          = var.status_check_type
  f5xc_api_p12_cert_password = var.f5xc_api_p12_cert_password
}