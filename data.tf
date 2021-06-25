data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "assume_role" {
  count = local.create_role ? 1 : 0

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "logs" {
  count = local.create_role && var.create_cloudwatch_log_group ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:${local.account_id}:*:*"]
  }
}

data "aws_iam_policy_document" "vpcAccessExecution" {
  count = length(coalesce(var.vpc_subnet_ids, [])) > 0 ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateNetworkInterface", "ec2:DeleteNetworkInterface", "ec2:DescribeNetworkInterfaces"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "kmsDecrypt" {
  count = var.kms_key_arn != null && var.kms_key_arn != "" ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = var.kms_key_arn
    condition {
      test = "StringEquals"
      variable = "kms:EncryptionContext:LambdaFunctionName"
      value : var.function_name
      
    }
  }
}

data "aws_iam_policy_document" "s3" {
  count = var.s3_existing_package != null && local.create_role ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject", "s3:Get*", "s3:List*"]
    resources = ["arn:aws:s3:::${local.s3_bucket}", "arn:aws:s3:::${local.s3_bucket}/*"]
  }
}
