data "http" "secure_mesh_site" {
  url             = format("%s/%s", var.f5xc_api_url, var.f5xc_secure_mesh_uri)
  method          = "POST"
  request_headers = {
    Authorization = format("APIToken %s", var.f5xc_api_token)
  }
  request_body = local.secure_mesh_site_data.json
}