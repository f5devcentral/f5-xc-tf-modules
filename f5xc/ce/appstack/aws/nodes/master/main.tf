resource "aws_instance" "master" {
  count                  = var.master_nodes_count
  ami                    = var.f5xc_ce_machine_image["voltstack"][var.f5xc_aws_region]
  instance_type          = var.instance_type_master
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.id
  user_data_base64       = var.f5xc_instance_config
  vpc_security_group_ids = [
    resource.aws_security_group.allow_traffic.id
  ]
  subnet_id                   = [for subnet in aws_subnet.slo : subnet.id][count.index % length(aws_subnet.slo)]
  source_dest_check           = false
  associate_public_ip_address = true

  root_block_device {
    volume_size = 40
  }

  tags = {
    Name                                             = format("%s-m%s", var.f5xc_cluster_name, count.index)
    Creator                                          = var.owner_tag
    "kubernetes.io/cluster/${var.f5xc_cluster_name}" = "owned"
  }
}

resource "aws_lb_target_group_attachment" "volterra_ce_attachment" {
  count            = var.master_nodes_count == 3 ? 3 : 0
  target_group_arn = aws_lb_target_group.controllers.id
  target_id        = aws_instance.master[count.index].id
  port             = 6443
}


resource "aws_instance" "instance" {
  ami                  = var.aws_instance_image
  tags                 = local.common_tags
  key_name             = var.ssh_public_key_name
  monitoring           = var.aws_instance_monitoring
  instance_type        = var.aws_instance_type
  user_data_base64     = base64encode(var.f5xc_instance_config)
  iam_instance_profile = var.aws_iam_instance_profile_id

  root_block_device {
    volume_size = var.aws_instance_disk_size
  }

  network_interface {
    network_interface_id = var.aws_interface_slo_id
    device_index         = "0"
  }

  dynamic "network_interface" {
    for_each = var.is_multi_nic ? [1] : []
    content {
      network_interface_id = var.aws_interface_sli_id
      device_index         = "1"
    }
  }

  timeouts {
    create = var.aws_instance_create_timeout
    update = var.aws_instance_update_timeout
    delete = var.aws_instance_delete_timeout
  }

  lifecycle {
    ignore_changes = [
      tags, iam_instance_profile, root_block_device, network_interface,
      user_data_base64, ami
    ]
  }
}

resource "aws_ebs_volume" "ebs_volume_instance" {
  availability_zone = aws_instance.instance.availability_zone
  size              = var.aws_instance_disk_size
  type              = "gp2"
  tags              = merge(
    local.common_tags, {
      "Name" = "ebs_volume_${lookup(aws_instance.instance.tags, "Name")}"
    }
  )
}

resource "aws_volume_attachment" "ebs_attach" {
  volume_id   = aws_ebs_volume.ebs_volume_instance.id
  device_name = "/dev/sdf"
  instance_id = aws_instance.instance.id
}


resource "aws_lb_target_group_attachment" "volterra_ce_attachment" {
  count            = var.f5xc_cluster_size == 3 ? 1 : 0
  target_group_arn = var.aws_lb_target_group_arn
  target_id        = aws_instance.instance.id
  port             = 6443
}

