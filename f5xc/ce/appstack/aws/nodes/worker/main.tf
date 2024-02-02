resource "aws_instance" "worker" {
  depends_on              = [aws_lb.nlb]
  count                   = var.worker_nodes_count
  ami                     = var.f5xc_ce_machine_image
  instance_type           = var.instance_type_worker
  iam_instance_profile    = aws_iam_instance_profile.instance_profile.id
  user_data               = templatefile("./appstack/aws/templates/cloud_init_worker.yaml", {
    site_token        = volterra_token.site.id,
    cluster_name      = var.f5xc_cluster_name,
    vp_manager_config = base64encode(local.vpm_config),
    ssh_public_key    = var.ssh_public_key,
    nlb               = aws_lb.nlb.dns_name 
  })
  vpc_security_group_ids      = [
    resource.aws_security_group.allow_traffic.id
  ]
  subnet_id                   = [for subnet in aws_subnet.slo : subnet.id][count.index % length(aws_subnet.slo)]
  source_dest_check           = false
  associate_public_ip_address = true

  root_block_device {
    volume_size = 40
  }
  
  tags = {
    Name        = format("%s-w%s", var.f5xc_cluster_name, count.index)
    deployment  = var.f5xc_cluster_name
    Creator     = var.owner_tag
    "kubernetes.io/cluster/${var.f5xc_cluster_name}"  = "owned"
  }
}

