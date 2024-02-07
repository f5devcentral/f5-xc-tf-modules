locals {
  aws_subnet_slo_id = var.aws_existing_slo_subnet_id != null ? data.aws_subnet.slo.0.id : aws_subnet.slo.0.id
  aws_subnet_sli_id = var.aws_existing_sli_subnet_id != null ? data.aws_subnet.sli.0.id : aws_subnet.sli.0.id
}