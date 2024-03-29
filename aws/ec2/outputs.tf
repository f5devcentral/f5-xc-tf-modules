output "aws_ec2_instance" {
  value = {
    id                 = aws_instance.instance.id
    public_ip          = aws_instance.instance.public_ip
    subnet_id          = aws_instance.instance.subnet_id
    private_ip         = aws_instance.instance.private_ip
    public_dns         = aws_instance.instance.public_dns
    private_dns        = aws_instance.instance.private_dns
    script_file        = var.aws_ec2_instance_script_file
    script_source      = "${var.template_output_dir_path}/${var.aws_ec2_instance_script_file}"
    script_content     = local.script_content
    custom_data_dirs   = var.aws_ec2_instance_custom_data_dirs
    script_destination = format("/tmp/%s", var.aws_ec2_instance_script_file)
    network_interfaces = {
      0 = data.aws_network_interface.outside
      1 = length(aws_instance.instance.network_interface) > 1 ? data.aws_network_interface.inside[0] : null
    }
  }
}