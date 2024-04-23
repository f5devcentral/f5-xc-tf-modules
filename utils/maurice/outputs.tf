output "endpoints" {
  value = {
    1.0          = substr(var.f5xc_api_url, 8, -1)
    1.1          = split("/", substr(var.f5xc_api_url, 8, -1))
    1.2          = split("/", substr(var.f5xc_api_url, 8, -1))[0]
    1.3          = split(".", split("/", substr(var.f5xc_api_url, 8, -1))[0])
    1.4          = slice(local.base_domain_list, 2, length(local.base_domain_list))
    1.5          = format("https://register.%s", join(".", slice(local.base_domain_list, 2, length(local.base_domain_list))))
    1.6          = local.is_production_env
    2            = local.base_domain_list
    3            = local.base_domain
    4            = local.maurice_endpoint_url
    5            = local.maurice_mtls_endpoint_url
    maurice      = local.maurice_endpoint_url
    maurice_mtls = local.maurice_mtls_endpoint_url
  }
}