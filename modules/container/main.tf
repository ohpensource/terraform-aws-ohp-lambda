resource "aws_lambda_function" "default" {
  function_name = var.function_name
  role          = var.create_role ? aws_iam_role.lambda[0].arn : var.role_name

  architectures = var.architectures
  kms_key_arn   = var.kms_key_arn
  timeout       = var.timeout
  description   = var.lambda_description

  image_uri    = var.container_image_uri
  package_type = "Image"

  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions
  tags                           = var.tags

  dynamic "snap_start" {
    for_each = var.snap_start ? [true] : []
    content {
      apply_on = "PublishedVersions"
    }
  }
  publish = var.snap_start

  dynamic "vpc_config" {
    for_each = local.create_function_in_vpc ? [true] : []
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
  count             = var.create_cloudwatch_log_group ? 1 : 0
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.cloudwatch_logs_retention_in_days
  kms_key_id        = var.cloudwatch_logs_kms_key_id
  tags              = var.tags
}

resource "aws_iam_role" "lambda" {
  count              = var.create_role ? 1 : 0
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json
  tags               = var.tags
}

resource "aws_iam_policy" "logs" {
  count  = local.create_cloudwatch_policy ? 1 : 0
  name   = "${var.function_name}-logs-policy"
  policy = data.aws_iam_policy_document.logs[0].json
}

resource "aws_iam_policy" "vpc" {
  count  = local.create_vpc_policy ? 1 : 0
  name   = "${var.function_name}-vpc-policy"
  policy = data.aws_iam_policy_document.vpc[0].json
}

resource "aws_iam_role_policy_attachment" "logs" {
  count      = local.create_cloudwatch_policy ? 1 : 0
  role       = aws_iam_role.lambda[0].name
  policy_arn = aws_iam_policy.logs[0].arn
}

resource "aws_iam_role_policy_attachment" "vpc" {
  count      = local.create_vpc_policy ? 1 : 0
  role       = aws_iam_role.lambda[0].name
  policy_arn = aws_iam_policy.vpc[0].arn
}

resource "aws_lambda_alias" "default" {
  count            = var.snap_start ? 1 : 0
  name             = "default"
  function_name    = aws_lambda_function.default.arn
  function_version = aws_lambda_function.default.version
}