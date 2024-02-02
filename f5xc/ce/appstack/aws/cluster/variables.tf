variable "f5xc_namespace" {
  type = string
}

variable "f5xc_cluster_name" {
  type = string
}

variable "f5xc_certified_hw" {
  type    = string
  default = "aws-byol-voltstack-combo"
}

variable "f5xc_appstack_master_nodes" {
  type = list(string)
}

variable "f5xc_appstack_worker_nodes" {
  type = list(string)
}