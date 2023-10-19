output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = element(concat(aws_lambda_function.default.*.arn, [""]), 0)
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value       = element(concat(aws_lambda_function.default.*.invoke_arn, [""]), 0)
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = element(concat(aws_lambda_function.default.*.function_name, [""]), 0)
}

output "lambda_alias_name" {
  description = "The name of the Lambda Function with alias when present"
  value       = element(concat(aws_lambda_alias.latest.*.name, [""]), 0)
}

output "lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = element(concat(aws_lambda_function.default.*.qualified_arn, [""]), 0)
}
output "lambda_function_qualified_invoke_arn" {
  description = "The Invoke ARN identifying your Lambda Function Version"
  value       = element(concat(aws_lambda_function.default.*.qualified_invoke_arn, [""]), 0)
}

output "lambda_function_version" {
  description = "Latest published version of Lambda Function"
  value       = element(concat(aws_lambda_function.default.*.version, [""]), 0)
}

output "lambda_function_last_modified" {
  description = "The date Lambda Function resource was last modified"
  value       = element(concat(aws_lambda_function.default.*.last_modified, [""]), 0)
}

output "lambda_function_kms_key_arn" {
  description = "The ARN for the KMS encryption key of Lambda Function"
  value       = element(concat(aws_lambda_function.default.*.kms_key_arn, [""]), 0)
}

output "lambda_function_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file"
  value       = element(concat(aws_lambda_function.default.*.source_code_hash, [""]), 0)
}

output "lambda_function_source_code_size" {
  description = "The size in bytes of the function .zip file"
  value       = element(concat(aws_lambda_function.default.*.source_code_size, [""]), 0)
}

# IAM Role
output "lambda_role_arn" {
  # count                           = local.create_role ? 1 : 0
  description = "The ARN of the IAM role created for the Lambda Function"
  value       = element(concat(aws_iam_role.lambda.*.arn, [""]), 0)
}

output "lambda_role_name" {
  # count                           = local.create_role ? 1 : 0
  description = "The name of the IAM role created for the Lambda Function"
  value       = element(concat(aws_iam_role.lambda.*.name, [""]), 0)
}

# CloudWatch Log Group
output "lambda_cloudwatch_log_group_arn" {
  # count       = var.create_function && var.create_cloudwatch_log_group ? 1 : 0
  description = "The ARN of the Cloudwatch Log Group"
  value       = element(concat(aws_cloudwatch_log_group.log.*.arn, [""]), 0)
}

output "lambda_cloudwatch_log_group_name" {
  # count       = var.create_function && var.create_cloudwatch_log_group ? 1 : 0
  description = "The name of the Cloudwatch Log Group"
  value       = element(concat(aws_cloudwatch_log_group.log.*.name, [""]), 0)
}