output "ce" {
  value = {
    nodes              = module.node.ce
    network            = module.network_common
    firewall           = local.create_network ? module.firewall.ce : null
    secure_mesh        = module.secure_mesh_site
    instance_group_url = module.node.instance_group_url
  }
}