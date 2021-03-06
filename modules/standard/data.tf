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
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${local.account_id}:*:*"]
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
