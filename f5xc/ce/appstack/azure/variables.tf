variable "is_sensitive" {
  description = "mark module output as sensitive"
  type        = bool
}

variable "status_check_type" {
  type    = string
  default = "token"
  validation {
    condition     = contains(["token", "cert"], var.status_check_type)
    error_message = format("Valid values for status_check_type: token or cert")
  }
}

variable "f5xc_tenant" {
  description = "F5 XC tenant"
  type        = string
}

variable "f5xc_api_url" {
  description = "F5 XC tenant api URL"
  type        = string
}

variable "f5xc_api_token" {
  description = "F5 XC api token"
  type        = string
}

variable "f5xc_token_name" {
  description = "F5 XC api token name"
  type        = string
  default     = ""
}

variable "f5xc_namespace" {
  description = "F5 XC namespace"
  type        = string
}

variable "f5xc_cluster_name" {
  description = "F5XC Site / Cluster name"
  type        = string
}

variable "f5xc_api_p12_file" {
  description = "F5 XC api ca cert"
  type        = string
  default     = ""
}