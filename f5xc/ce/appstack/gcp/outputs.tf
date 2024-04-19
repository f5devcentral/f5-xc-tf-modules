/*output "appstack" {
  value = {
    network = {
      common = module.network_common.common
    }
    appstack = module.cluster.appstack
    nodes = {
      master = {
        for node in keys(var.f5xc_cluster_nodes.master) : node => {
          node = module.node_master[node].ce
          config = {
            vpm                = module.config_master_node.ce["vpm"]
            user_data          = module.config_master_node.ce["user_data"]
            hosts_context_node = module.config_master_node.ce["hosts_context_node"]
          }
        }
      }
      worker = {
        for node in keys(var.f5xc_cluster_nodes.worker) : node => {
          node = module.node_worker[node].ce
          config = {
            vpm                = module.config_worker_node.ce["vpm"]
            user_data          = module.config_worker_node.ce["user_data"]
            hosts_context_node = module.config_worker_node.ce["hosts_context_node"]
          }
        }
      }
    }
  }
}*/


output "nodes" {
  value = module.node_master
}