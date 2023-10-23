locals {
  s3_bucket = var.s3_existing_package != null ? lookup(var.s3_existing_package, "bucket", null) : null
  s3_key    = var.s3_existing_package != null ? lookup(var.s3_existing_package, "key", null) : null

  role_name                = var.create_role ? coalesce(var.role_name, var.function_name, "*") : null
  account_id               = data.aws_caller_identity.current.account_id
  filename                 = var.local_existing_package != null ? var.local_existing_package : null
  create_cloudwatch_policy = var.create_role && var.create_cloudwatch_log_group
  create_s3_policy         = var.s3_existing_package != null && var.create_role
  create_function_in_vpc   = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null
  create_vpc_policy        = local.create_function_in_vpc != null && var.create_role
}
