common_tags_worker = {
    "kubernetes.io/cluster/${var.f5xc_cluster_name}" = "owned"
    "Owner"                                          = var.owner_tag
    "deployment"                                     = var.f5xc_cluster_name
  }