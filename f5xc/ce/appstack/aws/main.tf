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