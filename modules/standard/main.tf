data "aws_s3_bucket_object" "artifact" {
  count = var.s3_existing_package != null ? 1 : 0

  bucket = local.s3_bucket
  key    = local.s3_key
}

resource "aws_lambda_function" "default" {
  count = var.create_function ? 1 : 0

  function_name = var.function_name
  role          = var.create_role ? aws_iam_role.lambda[0].arn : var.role_name
  handler       = var.handler
  runtime       = var.runtime
  kms_key_arn   = var.kms_key_arn
  timeout       = var.timeout

  s3_bucket         = var.s3_existing_package != null ? data.aws_s3_bucket_object.artifact[0].bucket : null
  s3_key            = var.s3_existing_package != null ? data.aws_s3_bucket_object.artifact[0].key : null
  s3_object_version = var.s3_existing_package != null ? data.aws_s3_bucket_object.artifact[0].version_id : null

  filename                       = local.filename
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions
  layers                         = var.layers
  tags                           = length(var.lambda_tags) > 0 ? merge(var.tags, var.lambda_tags) : var.tags

  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []
    content {
      security_group_ids = var.vpc_security_group_ids
      subnet_ids         = var.vpc_subnet_ids
    }
  }

  dynamic "tracing_config" {
    for_each = var.tracing_mode == null ? [] : [true]
    content {
      mode = var.tracing_mode
    }
  }

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }
}

resource "aws_cloudwatch_log_group" "log" {
  count             = var.create_function && var.create_cloudwatch_log_group ? 1 : 0
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.cloudwatch_logs_retention_in_days
  kms_key_id        = var.cloudwatch_logs_kms_key_id
  tags              = length(var.cloudwatch_tags) > 0 ? merge(var.tags, var.cloudwatch_tags) : var.tags
}

resource "aws_iam_role" "lambda" {
  count              = local.create_role ? 1 : 0
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json
  tags               = length(var.role_tags) > 0 ? merge(var.tags, var.role_tags) : var.tags
}

resource "aws_iam_policy" "logs" {
  count  = local.create_role ? 1 : 0
  name   = "${var.function_name}-logs-policy"
  policy = local.cloudwatch_policy_arn
}

resource "aws_iam_policy" "s3" {
  count  = local.s3_policy_arn != null ? 1 : 0
  name   = "${var.function_name}-s3-policy"
  policy = local.s3_policy_arn
}

resource "aws_iam_role_policy_attachment" "logs" {
  count = local.create_role ? 1 : 0 #local.cloudwatch_policy_arn != null ? 1 : 0
  #name       = "${local.role_name}-logs"
  role       = aws_iam_role.lambda[0].name
  policy_arn = aws_iam_policy.logs[0].arn

}

resource "aws_iam_role_policy_attachment" "s3" {
  count = local.s3_policy_arn != null ? 1 : 0
  #name       = "${local.role_name}-s3"
  role       = aws_iam_role.lambda[0].name
  policy_arn = aws_iam_policy.s3[0].arn
}
