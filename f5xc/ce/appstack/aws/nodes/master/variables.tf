variable "owner_tag" {
  description = "set a tag called owner"
  type        = string
}

variable "common_tags" {
  type = map(string)
}

variable "f5xc_node_name" {
  type = string
}

variable "f5xc_cluster_name" {
  description = "F5XC Site / Cluster name"
  type        = string
}

variable "f5xc_instance_config" {
  type = string
}

variable "f5xc_cluster_size" {
  type = number
  validation {
    condition     = var.f5xc_cluster_size == 1 || var.f5xc_cluster_size == 3
    error_message = format("Valid values for f5xc_cluster_size: 1 or 3")
  }
}

variable "aws_instance_type" {
  type = string
}

variable "aws_iam_instance_profile_id" {
  type = string
}

variable "aws_instance_image" {
  type = string
}

variable "aws_instance_disk_size" {
  type    = string
  default = "40"
}

variable "aws_instance_create_timeout" {
  type    = string
  default = "60m"
}

variable "aws_instance_update_timeout" {
  type    = string
  default = "30m"
}

variable "aws_instance_delete_timeout" {
  type    = string
  default = "60m"
}

variable "aws_interface_slo_id" {
  type = string
}

variable "ssh_public_key_name" {
  type = string
}

variable "aws_instance_monitoring" {
  type    = bool
  default = false
}

variable "aws_lb_target_group_arn" {
  type = string
}