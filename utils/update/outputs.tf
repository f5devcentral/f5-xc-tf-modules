output "get_response" {
  value = data.restful_resource.get.output
}

output "data" {
  value = data.local_file.data.content
}

output "put_response" {
  value = restful_operation.update.output
}


