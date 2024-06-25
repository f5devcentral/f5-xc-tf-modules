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

variable "has_public_ip" {
  description = "whether the CE gets a public IP assigned to SLO"
  type        = bool
  default     = true
}

variable "instance_type" {
  description = "AWS EC2 instance flavour"
  type        = string
  default     = "t3.xlarge"
}

variable "owner_tag" {
  description = "set a tag called owner"
  type        = string
}

variable "create_new_aws_vpc" {
  description = "create new aws vpc"
  type        = bool
  default     = true
}

variable "create_new_aws_igw" {
  description = "create new aws igw"
  type        = bool
  default     = true
}

variable "create_new_aws_iam_profile" {
  description = "create new AWS IAM profile with mandatory actions"
  type        = string
  default     = true

}

variable "create_new_aws_slo_rt" {
  description = "create new slo subnet route table"
  type        = bool
  default     = true
}

variable "create_new_aws_sli_rt" {
  description = "create new sli subnet route table"
  type        = bool
  default     = true
}

variable "create_new_aws_slo_rta" {
  description = "create new slo aws route table association"
  type        = bool
  default     = true
}

variable "create_new_aws_sli_rta" {
  description = "create new sli aws route table association"
  type        = bool
  default     = true
}

variable "create_new_slo_security_group" {
  description = "create new aws F5XC CE SLO security group"
  type        = bool
  default     = true
}

variable "create_new_sli_security_group" {
  description = "create new aws F5XC CE SLI security group"
  type        = bool
  default     = true
}

variable "f5xc_ce_hosts_public_name" {
  type    = string
  default = "vip"
}

variable "cluster_workload" {
  type    = string
  default = ""
}

variable "ssh_public_key" {
  description = "New EC2 instance assigned public ssh key"
  type        = string
  default     = null
}

variable "aws_existing_key_pair_id" {
  description = "existing AWS ssh object id"
  type        = string
  default     = null
}

variable "aws_slo_rt_custom_ipv4_routes" {
  description = "Add custom ipv4 routes to aws slo rt table"
  type        = list(object({
    cidr_block           = string
    gateway_id           = optional(string)
    network_interface_id = optional(string)
  }))
  default = []
}

variable "aws_slo_rt_custom_ipv6_routes" {
  description = "Add custom ipv6 routes to aws slo rt table"
  type        = list(object({
    cidr_block           = string
    gateway_id           = optional(string)
    network_interface_id = optional(string)
  }))
  default = []
}

variable "aws_existing_vpc_id" {
  description = "inject existing aws vpc id"
  type        = string
  default     = ""
}


variable "aws_existing_sg_slo_ids" {
  description = "inject list of existing security group ids for SLO"
  type        = list(string)
  default     = []
}

variable "aws_existing_sg_sli_ids" {
  description = "inject list of existing security group ids for SLI"
  type        = list(string)
  default     = []
}

variable "aws_existing_iam_profile_name" {
  description = "Create new AWS IAM profile for CE with mandatory actions"
  type        = string
  default     = null
}

variable "aws_security_group_rules_slo_egress_default" {
  description = "default aws security groups assigned to slo egress"
  type        = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = -1
      to_port     = -1
      ip_protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "aws_security_group_rules_slo_ingress_default" {
  description = "default aws security groups assigned to slo ingress"
  type        = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = -1
      to_port     = -1
      ip_protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "aws_security_group_rules_sli_egress_default" {
  description = "aws security groups assigned to sli egress"
  type        = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = -1
      to_port     = -1
      ip_protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "aws_security_group_rules_sli_ingress_default" {
  description = "aws security groups assigned to sli ingress"
  type        = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = -1
      to_port     = -1
      ip_protocol = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "aws_security_group_rules_slo_egress" {
  description = "provide custom aws security groups assigned to slo egress"
  type        = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_blocks = list(string)
  }))
}

variable "aws_security_group_rules_slo_ingress" {
  description = "provide custom aws security groups assigned to slo ingress"
  type        = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_blocks = list(string)
  }))
}

variable "aws_security_group_rules_sli_egress" {
  description = "provide custom aws security groups assigned to sli egress"
  type        = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "aws_security_group_rules_sli_ingress" {
  description = "provide custom aws security groups assigned to sli ingress"
  type        = list(object({
    from_port   = number
    to_port     = number
    ip_protocol = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "aws_key_pair_id" {
  description = "The ID of existing AWS ssh key pair"
  type        = string
  default     = null
}

variable "aws_iam_policy_id" {
  description = "THe ID of existing AWS IAM policy"
  type        = string
  default     = null
}

variable "f5xc_cluster_labels" {
  description = "F5 XC CE Cluster labels"
  type        = map(string)
}

variable "f5xc_cluster_latitude" {
  description = "geo latitude"
  type        = number
  default     = -73.935242
}

variable "f5xc_cluster_longitude" {
  description = "geo longitude"
  type        = number
  default     = 40.730610
}

variable "f5xc_api_url" {
  description = "F5 XC tenant api URL"
  type        = string
}

variable "f5xc_api_p12_file" {
  description = "F5 XC api ca cert"
  type        = string
  default     = ""
}

variable "f5xc_api_token" {
  description = "F5 XC api token"
  type        = string
  default     = ""
}

variable "f5xc_tenant" {
  description = "F5 XC tenant"
  type        = string
}

variable "f5xc_token_name" {
  description = "F5 XC api token name"
  type        = string
}

variable "f5xc_namespace" {
  description = "F5 XC namespace"
  type        = string
}

variable "f5xc_ce_gateway_type_voltstack" {
  type    = string
  default = "voltstack"
}

variable "f5xc_ce_gateway_type_ingress" {
  type    = string
  default = "ingress_gateway"
}

variable "f5xc_ce_gateway_type_ingress_egress" {
  type    = string
  default = "ingress_egress_gateway"
}

variable "f5xc_ce_gateway_type" {
  type = string
  validation {
    condition     = contains(["ingress_egress_gateway", "ingress_gateway", "voltstack"], var.f5xc_ce_gateway_type)
    error_message = format("Valid values for gateway_type: ingress_egress_gateway, ingress_gateway, voltstack")
  }
}

variable "f5xc_ce_to_re_tunnel_type" {
  description = "CE to RE tunnel type"
  type        = string
  validation {
    condition     = contains(["ssl", "ipsec"], var.f5xc_ce_to_re_tunnel_type)
    error_message = format("Valid values for tunnel_type: ssl, ipsec")
  }
  default = "ipsec"
}

variable "f5xc_registration_wait_time" {
  type    = number
  default = 60
}

variable "f5xc_registration_retry" {
  type    = number
  default = 20
}

variable "f5xc_aws_vpc_az_nodes" {
  type = map(map(string))
  validation {
    condition     = length(var.f5xc_aws_vpc_az_nodes) == 1 || length(var.f5xc_aws_vpc_az_nodes) == 3 || length(var.f5xc_aws_vpc_az_nodes) == 0
    error_message = "f5xc_aws_vpc_az_nodes must be 0,1 or 3"
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "f5xc_cluster_name" {
  type = string
}

variable "f5xc_enable_offline_survivability_mode" {
  type    = bool
  default = false
}

variable "f5xc_api_p12_cert_password" {
  description = "XC API cert file password used later in status module to retrieve site status"
  type        = string
  default     = ""
}

variable "f5xc_is_secure_cloud_ce" {
  description = "whether CE should be secured by applying security rules on SLO and SLI + NAT GW + SLO private IP"
  type        = bool
  default     = false
}

variable "f5xc_is_private_cloud_ce" {
  description = "whether CE should be private with SLO has private IP and NAT GW in front"
  type        = bool
  default     = false
}

variable "f5xc_ce_slo_enable_secure_sg" {
  description = "whether CE should be secured by applying security rules on SLO"
  type        = bool
  default     = false
}

variable "f5xc_site_type_is_secure_mesh_site" {
  type    = bool
  default = true
}

variable "f5xc_ce_machine_image" {
  type = object({
    ingress_gateway = object({
      af-south-1     = string
      ap-south-1     = string
      eu-north-1     = string
      eu-west-3      = string
      eu-south-1     = string
      eu-west-2      = string
      eu-west-1      = string
      ap-northeast-3 = string
      ap-northeast-2 = string
      me-south-1     = string
      ap-northeast-1 = string
      ca-central-1   = string
      sa-east-1      = string
      ap-east-1      = string
      ap-southeast-1 = string
      ap-southeast-2 = string
      eu-central-1   = string
      ap-southeast-3 = string
      us-east-1      = string
      us-east-2      = string
      us-west-1      = string
      us-west-2      = string
    })
    ingress_egress_gateway = object({
      af-south-1     = string
      ap-south-1     = string
      eu-north-1     = string
      eu-west-3      = string
      eu-south-1     = string
      eu-west-2      = string
      eu-west-1      = string
      ap-northeast-3 = string
      ap-northeast-2 = string
      me-south-1     = string
      ap-northeast-1 = string
      ca-central-1   = string
      sa-east-1      = string
      ap-east-1      = string
      ap-southeast-1 = string
      ap-southeast-2 = string
      eu-central-1   = string
      ap-southeast-3 = string
      us-east-1      = string
      us-east-2      = string
      us-west-1      = string
      us-west-2      = string
    })
    voltstack_gateway = object({
      af-south-1     = string
      ap-south-1     = string
      eu-north-1     = string
      eu-west-3      = string
      eu-south-1     = string
      eu-west-2      = string
      eu-west-1      = string
      ap-northeast-3 = string
      ap-northeast-2 = string
      me-south-1     = string
      ap-northeast-1 = string
      ca-central-1   = string
      sa-east-1      = string
      ap-east-1      = string
      ap-southeast-1 = string
      ap-southeast-2 = string
      eu-central-1   = string
      ap-southeast-3 = string
      us-east-1      = string
      us-east-2      = string
      us-west-1      = string
      us-west-2      = string
    })
  })
  default = {
    ingress_gateway = {
      af-south-1     = "ami-0b0000ea90bfd3979"
      ap-south-1     = "ami-07d3b0d62668e099c"
      eu-north-1     = "ami-062eab458f1e743c2"
      eu-west-3      = "ami-07abf7d401fd8901f"
      eu-south-1     = "ami-0935c8f464feb23ff"
      eu-west-2      = "ami-0afcd5a3c86d26efc"
      eu-west-1      = "ami-008f5dadf7e270bad"
      ap-northeast-3 = "ami-0c735bbbf41e0228b"
      ap-northeast-2 = "ami-0485f9cc8345a7743"
      me-south-1     = "ami-014f663502f043283"
      ap-northeast-1 = "ami-0e5262aa2973afb5b"
      ca-central-1   = "ami-02ea82a0f96447dd9"
      sa-east-1      = "ami-00ad4feae6f2695c6"
      ap-east-1      = "ami-07bbd8ff5f65490e1"
      ap-southeast-1 = "ami-096bad088a3d2d80e"
      ap-southeast-2 = "ami-0353a50c4d920eeb8"
      eu-central-1   = "ami-04f079735f83685cd"
      ap-southeast-3 = "ami-0acfb18c5710ff51d"
      us-east-1      = "ami-0fa5987b8951c3a4a"
      us-east-2      = "ami-0c821ea67a1810b87"
      us-west-1      = "ami-06c50d823c5170da1"
      us-west-2      = "ami-0456e5ee3487081ac"
    }
    ingress_egress_gateway = {
      af-south-1     = "ami-020fa5dc82f5bbc4c"
      ap-south-1     = "ami-0cac8bf56886b37dc"
      eu-north-1     = "ami-03d49c88b22aed987"
      eu-west-3      = "ami-059f3a70b65ae8eab"
      eu-south-1     = "ami-074f961d3b99fa4c0"
      eu-west-2      = "ami-0c4f6dc1c4571687b"
      eu-west-1      = "ami-07a8974e0efe8db0a"
      ap-northeast-3 = "ami-0ce0e3282b7bc209d"
      ap-northeast-2 = "ami-0ea627878097df22c"
      me-south-1     = "ami-058b2cdec962dd79e"
      ap-northeast-1 = "ami-0ce4ada5b93d5daef"
      ca-central-1   = "ami-07f4e9fef64a0ae05"
      sa-east-1      = "ami-0224f9eee740572c3"
      ap-east-1      = "ami-06442e9e8ad03318b"
      ap-southeast-1 = "ami-0068c3048411ff88d"
      ap-southeast-2 = "ami-025098f869deed5c2"
      eu-central-1   = "ami-075269fb044288859"
      ap-southeast-3 = "ami-05e261a4a17f02ddd"
      us-east-1      = "ami-0d270961ee0acb7fb"
      us-east-2      = "ami-029c8200b38c48fd5"
      us-west-1      = "ami-0eb34c3cae6268d03"
      us-west-2      = "ami-06257c7331bd50fc0"
    }
    voltstack_gateway = {
      af-south-1     = "ami-0585621668f7bfe0a"
      ap-south-1     = "ami-03df1cb32c5691768"
      eu-north-1     = "ami-02e23a44867ad6c14"
      eu-west-3      = "ami-0af9b4d7f25faaf00"
      eu-south-1     = "ami-09efe0fb6a22a8946"
      eu-west-2      = "ami-06d440b7d9319c711"
      eu-west-1      = "ami-0f6d282a177cd5fbb"
      ap-northeast-3 = "ami-04296826152a859c7"
      ap-northeast-2 = "ami-0612123a0a3e199ae"
      me-south-1     = "ami-04e251aa79a39f8c3"
      ap-northeast-1 = "ami-00b5967ff372f59b3"
      ca-central-1   = "ami-0007bac6f0068c0ac"
      sa-east-1      = "ami-04a2a20497700ba32"
      ap-east-1      = "ami-01efdcf6d2eb6f9bc"
      ap-southeast-1 = "ami-03b0097339e7a6b72"
      ap-southeast-2 = "ami-0cb8a57f76e784b3c"
      eu-central-1   = "ami-0fd6f92f2f688edb7"
      ap-southeast-3 = "ami-0f12b570363dcf61b"
      us-east-1      = "ami-01ff8ef1691c3e82e"
      us-east-2      = "ami-05393141861308eee"
      us-west-1      = "ami-074cdc10e8a43b160"
      us-west-2      = "ami-0931d0d98985c1231"
    }
  }
}

variable "f5xc_ce_performance_enhancement_mode" {
  type = object({
    perf_mode_l7_enhanced = bool
    perf_mode_l3_enhanced = optional(object({
      jumbo_frame_enabled = bool
    }))
  })
  default = {
    perf_mode_l7_enhanced = true
  }
}

variable "aws_vpc_cidr_block" {
  description = "AWS vpc CIDR block"
  type        = string
  default     = ""
}

variable "f5xc_ip_ranges_Americas_TCP" {
  type    = list(string)
  default = [
    "84.54.62.0/25", "185.94.142.0/25", "185.94.143.0/25", "159.60.190.0/24", "5.182.215.0/25", "84.54.61.0/25",
    "23.158.32.0/25",
  ]
}
variable "f5xc_ip_ranges_Americas_UDP" {
  type    = list(string)
  default = [
    "23.158.32.0/25", "84.54.62.0/25", "185.94.142.0/25", "185.94.143.0/25", "159.60.190.0/24", "5.182.215.0/25",
    "84.54.61.0/25",
  ]
}
variable "f5xc_ip_ranges_Europe_TCP" {
  type    = list(string)
  default = [
    "84.54.60.0/25", "185.56.154.0/25", "159.60.162.0/24", "159.60.188.0/24", "5.182.212.0/25", "5.182.214.0/25",
    "159.60.160.0/24", "5.182.213.0/25", "5.182.213.128/25",
  ]
}
variable "f5xc_ip_ranges_Europe_UDP" {
  type    = list(string)
  default = [
    "5.182.212.0/25", "185.56.154.0/25", "159.60.160.0/24", "5.182.213.0/25", "5.182.213.128/25", "5.182.214.0/25",
    "84.54.60.0/25", "159.60.162.0/24", "159.60.188.0/24",
  ]
}
variable "f5xc_ip_ranges_Asia_TCP" {
  type    = list(string)
  default = [
    "103.135.56.0/25", "103.135.56.128/25", "103.135.58.128/25", "159.60.189.0/24", "159.60.166.0/24",
    "103.135.57.0/25", "103.135.59.0/25", "103.135.58.0/25", "159.60.164.0/24",
  ]
}
variable "f5xc_ip_ranges_Asia_UDP" {
  type    = list(string)
  default = [
    "103.135.57.0/25", "103.135.56.128/25", "103.135.59.0/25", "103.135.58.0/25", "159.60.166.0/24", "159.60.164.0/24",
    "103.135.56.0/25", "103.135.58.128/25", "159.60.189.0/24",
  ]
}

variable "f5xc_ce_egress_ip_ranges" {
  type        = list(string)
  description = "Egress IP ranges for F5 XC CE"
  default     = [
    "20.33.0.0/16",
    "74.125.0.0/16",
    "18.64.0.0/10",
    "52.223.128.0/18",
    "20.152.0.0/15",
    "13.107.238.0/24",
    "142.250.0.0/15",
    "20.34.0.0/15",
    "52.192.0.0/12",
    "52.208.0.0/13",
    "52.223.0.0/17",
    "18.32.0.0/11",
    "3.208.0.0/12",
    "13.107.237.0/24",
    "20.36.0.0/14",
    "52.222.0.0/16",
    "52.220.0.0/15",
    "3.0.0.0/9",
    "100.64.0.0/10",
    "54.88.0.0/16",
    "52.216.0.0/14",
    "108.177.0.0/17",
    "20.40.0.0/13",
    "54.64.0.0/11",
    "172.253.0.0/16",
    "20.64.0.0/10",
    "20.128.0.0/16",
    "172.217.0.0/16",
    "173.194.0.0/16",
    "20.150.0.0/15",
    "20.48.0.0/12",
    "72.19.3.0/24",
    "18.128.0.0/9",
    "23.20.0.0/14",
    "13.104.0.0/14",
    "13.96.0.0/13",
    "13.64.0.0/11",
    "13.249.0.0/16",
    "34.192.0.0/10",
    "3.224.0.0/12",
    "54.208.0.0/13",
    "54.216.0.0/14",
    "108.156.0.0/14",
    "54.144.0.0/12",
    "54.220.0.0/15",
    "54.192.0.0/12",
    "54.160.0.0/11",
    "52.88.0.0/13",
    "52.84.0.0/14",
    "52.119.128.0/17",
    "54.240.192.0/18",
    "52.94.208.0/21"
  ]
}