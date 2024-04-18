locals {
  create_network        = var.gcp_existing_network_slo == null ? true : false
  create_subnetwork     = var.gcp_existing_subnet_network_slo == null ? true : false
  f5xc_cluster_node_azs = [for node in var.f5xc_ce_nodes : node["az"]]
}