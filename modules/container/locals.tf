locals {
  role_name                = var.create_role ? coalesce(var.role_name, var.function_name, "*") : null
  account_id               = data.aws_caller_identity.current.account_id
  create_cloudwatch_policy = var.create_role && var.create_cloudwatch_log_group
  create_function_in_vpc   = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null
  create_vpc_policy        = local.create_function_in_vpc != null && var.create_role
}
