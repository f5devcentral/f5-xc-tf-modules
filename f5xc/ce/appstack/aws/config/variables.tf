variable "f5xc_site_token" {
  type = string
}

variable "f5xc_cluster_name" {
  type = string
}

variable "f5xc_certified_hardware_endpoint" {
  type    = string
  default = "https://vesio.blob.core.windows.net/releases/certified-hardware/aws.yml"
}

variable "f5xc_ce_hosts_public_name" {
  type = string
}

variable "f5xc_ce_hosts_public_address" {
  type = string
}

variable "f5xc_cluster_labels" {
  type = map(string)
}

variable "f5xc_cluster_latitude" {
  type = number
}

variable "f5xc_cluster_longitude" {
  type = number
}

variable "f5xc_cluster_type" {
  type    = string
  default = "ce"
}

variable "maurice_endpoint" {
  type = string
}

variable "maurice_mtls_endpoint" {
  type = string
}

variable "ntp_servers" {
  type    = string
  default = "pool.ntp.org"
}

variable "reboot_strategy_node" {
  type    = string
  default = "off"
}

variable "aws_nlb_dns_name" {
  type = string
}

variable "templates_dir" {
  type    = string
  default = "templates"
}

variable "ssh_public_key" {
  type = string
}


