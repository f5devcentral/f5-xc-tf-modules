output "appstack" {
  value = {
    # vpc_id = var.aws_existing_vpc_id != "" ? var.aws_existing_vpc_id : null
    iam = {
      role             = aws_iam_role.role
      policy           = aws_iam_policy.policy
      attachment       = aws_iam_role_policy_attachment.attachment
      instance_profile = aws_iam_instance_profile.instance_profile
    }
    ssh_key = aws_key_pair.aws_key
    nlb     = length(var.f5xc_aws_vpc_az_nodes) == 3 ? {
      # nlb = module.network_nlb[0].nlb
    } : null
    nodes = {
      master = {
        for node in keys(var.f5xc_aws_vpc_az_nodes) : node => {
          # node    = module.node[node].ce
          config = {
            vpm                = module.config[node].ce["vpm"]
            user_data          = module.config[node].ce["user_data_master"]
            hosts_context_node = module.config[node].ce["hosts_context_node"]
          }
          #network = {
          #  common = module.network_common.common
          #  node   = module.network_node[node].ce
          #}
          #secure_ce = var.f5xc_is_secure_cloud_ce ? module.secure_ce[node].ce : null
        }
      }
      worker = {}
    }
  }
}

/*output "appstack" {
  value = {
    vpc_id        = var.aws_existing_vpc_id != "" ? var.aws_existing_vpc_id : null
    slo           = aws_subnet.slo
    master        = aws_instance.master
    master_nodes  = [ for node in aws_instance.master : split(".", node.private_dns)[0] ]
    worker        = aws_instance.worker
    worker_nodes  = [ for node in aws_instance.worker : split(".", node.private_dns)[0] ]
    subnet_ids    = [ for subnet in aws_subnet.slo : subnet.id ]
    gateway       = aws_internet_gateway.gateway
    nlb           = aws_lb.nlb
    ssh_key       = aws_key_pair.aws_key
    security_group = resource.aws_security_group.allow_traffic
    iam    = {
      role             = aws_iam_role.role
      policy           = aws_iam_policy.policy
      attachment       = aws_iam_role_policy_attachment.attachment
      instance_profile = aws_iam_instance_profile.instance_profile
    }
  }
}

output "kubeconfig" {
  value = local_file.kubeconfig.filename
}*/