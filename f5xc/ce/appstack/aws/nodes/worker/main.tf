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