locals {
  s3_bucket = var.s3_existing_package != null ? lookup(var.s3_existing_package, "bucket", null) : null
  s3_key    = var.s3_existing_package != null ? lookup(var.s3_existing_package, "key", null) : null

  create_role           = var.create_function && var.create_role
  role_name             = local.create_role ? coalesce(var.role_name, var.function_name, "*") : null
  account_id            = data.aws_caller_identity.current.account_id
  filename              = var.local_existing_package != null ? var.local_existing_package : null
  cloudwatch_policy_arn = local.create_role ? join("", data.aws_iam_policy_document.logs.*.json) : null
  s3_policy_arn         = var.s3_existing_package != null && local.create_role ? join("", data.aws_iam_policy_document.s3.*.json) : null
}
