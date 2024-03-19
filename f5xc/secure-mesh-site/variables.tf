variable "f5xc_api_url" {
  type = string
}

variable "f5xc_api_token" {
  type = string
}

variable "f5xc_tenant" {
  type = string
}

variable "f5xc_namespace" {
  type = string
}

variable "f5xc_cluster_name" {
  type = string
}

variable "f5xc_cluster_labels" {
  type = map(string)
}

variable "f5xc_nodes" {
  type = list(object({
    name = string
  }))
}

variable "f5xc_cluster_latitude" {
  type = number
}

variable "f5xc_cluster_longitude" {
  type = number
}

variable "f5xc_annotations" {
  type    = map(string)
  default = {}
}

variable "f5xc_enable_offline_survivability_mode" {
  type    = bool
  default = false
}

variable "f5xc_ce_performance_enhancement_mode" {
  type = object({
    perf_mode_l7_enhanced = bool
    perf_mode_l3_enhanced = optional(object({
      jumbo_frame_enabled = bool
    }))
  })
}

variable "f5xc_site_type_certified_hw" {
  type    = map(string)
  default = {
    ingress_gateway        = "aws-byol-voltmesh"
    voltstack_gateway      = "aws-byol-voltstack-combo"
    ingress_egress_gateway = "aws-byol-multi-nic-voltmesh"
  }
}

variable "f5xc_ce_gateway_type" {
  type = string
  validation {
    condition = contains([
      "ingress_egress_gateway", "ingress_gateway", "voltstack_gateway"
    ], var.f5xc_ce_gateway_type)
    error_message = format("Valid values for gateway_type: ingress_egress_gateway, ingress_gateway, voltstack_gateway")
  }
}

variable "f5xc_secure_mesh_uri" {
  type    = string
  default = "config/namespaces/system/securemesh_sites"
}