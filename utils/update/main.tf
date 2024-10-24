data "restful_resource" "get" {
  id = format("/%s?response_format=GET_RSP_FORMAT_DEFAULT", var.f5xc_api_get_uri)
  header = {
    Accept                      = "application/json"
    x-volterra-apigw-tenant     = var.f5xc_tenant
    Access-Control-Allow-Origin = "*"
  }
}

locals {
  command = var.del_key != "" ? "echo '${jsonencode(data.restful_resource.get.output)}' | jq . | jq 'del(.spec.${var.merge_key}.${var.del_key})' | jq '.spec.${var.merge_key} +=${var.merge_data}' > ${var.output_file_name}" : "echo '${jsonencode(data.restful_resource.get.output)}' | jq . | jq '.spec.${var.merge_key} +=${var.merge_data}' > ${var.output_file_name}"
}

resource "terraform_data" "merge" {
  depends_on = [data.restful_resource.get]
  triggers_replace = timestamp()

  provisioner "local-exec" {
    command = local.command
  }
}

data "local_file" "data" {
  depends_on = [terraform_data.merge]
  filename = var.output_file_name
}

resource "restful_operation" "update" {
  path = format("%s?response_format=GET_RSP_FORMAT_DEFAULT", var.f5xc_api_update_uri)
  method = "PUT"
  header = {
    Accept                      = "application/json"
    Content-Type                = "application/json"
    x-volterra-apigw-tenant     = var.f5xc_tenant
    Access-Control-Allow-Origin = "*"
  }
  body = jsondecode(data.local_file.data.content)
}