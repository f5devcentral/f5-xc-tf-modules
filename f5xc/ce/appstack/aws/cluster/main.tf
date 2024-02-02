resource "volterra_k8s_cluster" "cluster" {
  name                              = var.f5xc_cluster_name
  namespace                         = var.f5xc_namespace
  use_default_psp                   = true
  global_access_enable              = true
  no_cluster_wide_apps              = true
  no_insecure_registries            = true
  use_default_cluster_roles         = true
  cluster_scoped_access_permit      = true
  use_default_cluster_role_bindings = true

  local_access_config {
    local_domain = format("%s.local", var.f5xc_cluster_name)
    default_port = true
  }
}

resource "volterra_voltstack_site" "cluster" {
  depends_on              = [aws_instance.master, aws_instance.worker]
  name                    = var.f5xc_cluster_name
  namespace               = var.f5xc_namespace
  disable_gpu             = true
  deny_all_usb            = true
  master_nodes            = [for node in aws_instance.master : split(".", node.private_dns)[0]]
  worker_nodes            = [for node in aws_instance.worker : split(".", node.private_dns)[0]]
  no_bond_devices         = true
  logs_streaming_disabled = true
  default_network_config  = true
  default_storage_config  = true
  volterra_certified_hw   = var.f5xc_certified_hw

  k8s_cluster {
    namespace = var.f5xc_namespace
    name      = volterra_k8s_cluster.cluster.name
  }
}