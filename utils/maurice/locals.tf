locals {
  base_offset               = length(substr(var.f5xc_api_url, 8, -1)) - 4
  base_domain_list          = split(".", split("/", substr(var.f5xc_api_url, 8, -1))[0])
  base_domain               = join(".", slice(local.base_domain_list, 1, length(local.base_domain_list)))
  maurice_endpoint_url      = format("https://register.%s", local.base_domain)
  maurice_mtls_endpoint_url = format("https://register-tls.%s", local.base_domain)
}
