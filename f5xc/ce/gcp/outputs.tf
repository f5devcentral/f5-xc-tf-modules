output "ce" {
  value = {
    nodes       = module.node.ce
    network     = module.network_common
    firewall    = local.create_network ? module.firewall.ce : null
    secure_mesh = module.secure_mesh_site
  }
}

output "create_network" {
  value = local.create_network
}