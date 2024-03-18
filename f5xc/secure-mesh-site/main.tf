/*resource "restapi_object" "secure_mesh_site" {
  path         = "/config/namespaces/system/securemesh_sites"
  data         = local.secure_mesh_site_data.json
  id_attribute = "metadata/name"
}*/

data "http" "secure_mesh_site" {
  url             = format("%s/%s", var.f5xc_api_url, "/config/namespaces/system/securemesh_sites")
  method          = "POST"
  request_headers = {
    Authorization = format("APIToken %s", var.f5xc_api_token)
  }
  request_body = local.secure_mesh_site_data.json
}