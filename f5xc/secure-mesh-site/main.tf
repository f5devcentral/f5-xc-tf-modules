/*resource "restapi_object" "secure_mesh_site" {
  path         = "/config/namespaces/system/securemesh_sites"
  data         = local.secure_mesh_site_data.json
  id_attribute = "metadata/name"
}*/

data "http" "secure_mesh_site" {
  # count           = fileexists(local.kubeconfig) ? 0 : 1
  url             = format("%s/%s/%s/%s", var.f5xc_api_url, var.f5xc_rest_uri_sites, var.f5xc_k8s_cluster_name, var.f5xc_k8s_config_types[var.f5xc_k8s_config_type])
  method          = "POST"
  request_headers = {
    Authorization = format("APIToken %s", var.f5xc_api_token)
  }
  request_body = jsonencode({ expiration_timestamp : time_offset.exp_time.rfc3339, site : var.f5xc_k8s_cluster_name })
}