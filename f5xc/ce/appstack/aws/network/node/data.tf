data "aws_subnet" "slo" {
  count = var.aws_existing_slo_subnet_id != "" ? 1 : 0
  id    = var.aws_existing_slo_subnet_id
}