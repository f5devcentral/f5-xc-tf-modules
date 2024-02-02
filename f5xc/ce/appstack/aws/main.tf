resource "volterra_token" "site" {
  name      = var.f5xc_token_name != "" ? var.f5xc_token_name : var.f5xc_cluster_name
  namespace = var.f5xc_namespace
}

resource "aws_key_pair" "aws_key" {
  key_name   = var.f5xc_cluster_name
  public_key = var.ssh_public_key
}

module "maurice" {
  source       = "../../../../utils/maurice"
  f5xc_api_url = var.f5xc_api_url
}

module "network_common" {
  source                               = "./network/common"
  owner_tag                            = var.owner_tag
  common_tags                          = local.common_tags
  create_new_aws_vpc                   = var.create_new_aws_vpc
  f5xc_cluster_name                    = var.f5xc_cluster_name
  aws_vpc_cidr_block                   = var.aws_vpc_cidr_block
  aws_existing_vpc_id                  = var.aws_existing_vpc_id
  aws_security_group_rules_slo_egress  = length(var.aws_security_group_rules_slo_egress) > 0 ? var.aws_security_group_rules_slo_egress : var.aws_security_group_rules_slo_egress_default
  aws_security_group_rules_slo_ingress = length(var.aws_security_group_rules_slo_ingress) > 0 ? var.aws_security_group_rules_slo_ingress : var.aws_security_group_rules_slo_ingress_default
}

module "network_node" {
  source                     = "./network/node"
  for_each                   = {for k, v in var.f5xc_aws_vpc_az_nodes : k=>v}
  owner_tag                  = var.owner_tag
  node_name                  = format("%s-%s", var.f5xc_cluster_name, each.key)
  common_tags                = local.common_tags
  has_public_ip              = var.has_public_ip
  aws_vpc_az                 = var.f5xc_aws_vpc_az_nodes[each.key]["f5xc_aws_vpc_az_name"]
  aws_vpc_id                 = var.aws_existing_vpc_id != "" ? var.aws_existing_vpc_id : module.network_common.common["vpc"]["id"]
  aws_sg_slo_ids             = module.network_common.common["sg_slo_ids"]
  aws_subnet_slo_cidr        = var.f5xc_aws_vpc_az_nodes[each.key]["f5xc_aws_vpc_slo_subnet"]
  aws_slo_subnet_rt_id       = module.network_common.common["slo_subnet_rt"]["id"]
  aws_existing_slo_subnet_id = lookup(var.f5xc_aws_vpc_az_nodes[each.key], "aws_existing_slo_subnet_id") != "" ? var.f5xc_aws_vpc_az_nodes[each.key]["aws_existing_slo_subnet_id"] : null
}

module "config" {
  source                       = "./config"
  for_each                     = {for k, v in var.f5xc_aws_vpc_az_nodes : k=>v}
  ssh_public_key               = var.ssh_public_key
  f5xc_site_token              = volterra_token.site.id
  f5xc_cluster_name            = var.f5xc_cluster_name
  f5xc_cluster_labels          = {} # var.f5xc_cluster_labels
  f5xc_cluster_latitude        = var.f5xc_cluster_latitude
  f5xc_cluster_longitude       = var.f5xc_cluster_longitude
  f5xc_ce_hosts_public_name    = var.f5xc_ce_hosts_public_name
  f5xc_ce_hosts_public_address = "" #module.network_node[each.key].ce["slo"]["public_dns"][0]
  maurice_endpoint             = module.maurice.endpoints.maurice
  maurice_mtls_endpoint        = module.maurice.endpoints.maurice_mtls
  aws_nlb_dns_name             = ""
}

/*resource "volterra_registration_approval" "master" {
  depends_on   = [volterra_voltstack_site.cluster]
  count        = var.master_nodes_count
  cluster_name = volterra_voltstack_site.cluster.name
  cluster_size = var.master_nodes_count
  hostname     = split(".", aws_instance.master[count.index].private_dns)[0]
  wait_time    = var.f5xc_registration_wait_time
  retry        = var.f5xc_registration_retry
}

module "site_wait_for_online" {
  depends_on     = [volterra_voltstack_site.cluster]
  source         = "../../../status/site"
  f5xc_api_token = var.f5xc_api_token
  f5xc_api_url   = var.f5xc_api_url
  f5xc_namespace = var.f5xc_namespace
  f5xc_site_name = var.f5xc_cluster_name
  f5xc_tenant    = var.f5xc_tenant
  is_sensitive   = var.is_sensitive
}

resource "volterra_registration_approval" "worker" {
  depends_on   = [module.site_wait_for_online]
  count        = var.worker_nodes_count
  cluster_name = volterra_voltstack_site.cluster.name
  cluster_size = var.master_nodes_count
  hostname     = split(".", aws_instance.worker[count.index].private_dns)[0]
  wait_time    = var.f5xc_registration_wait_time
  retry        = var.f5xc_registration_retry
}*/