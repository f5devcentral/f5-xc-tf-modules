output "ce" {
  value = {
    vpm                = local.vpm_config
    user_data_master   = local.master_cloud_cfg
    user_data_worker   = local.worker_cloud_cfg
    hosts_context_node = local.hosts_context_node
  }
}