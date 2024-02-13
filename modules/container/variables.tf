variable "create_role" {
  description = "Controls whether Lambda Function IAM Role is created"
  type        = bool
  default     = false
}

variable "role_name" {
  description = "Name of IAM role to use for Lambda Function"
  type        = string
  default     = null
}

variable "function_name" {
  description = "A unique name for your Lambda Function"
  type        = string
}

variable "reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for this Lambda Function. A value of 0 disables Lambda Function from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1."
  type        = number
  default     = -1
}

variable "lambda_description" {
  description = "Description of Lambda function"
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = "The ARN of KMS key to use by your Lambda Function"
  type        = string
  default     = null
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Valid value between 128 MB to 10,240 MB (10 GB), in 64 MB increments."
  type        = number
  default     = 128
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 3
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "tracing_mode" {
  description = "Tracing mode of the Lambda Function. Valid value can be either PassThrough or Active."
  type        = string
  default     = null
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC."
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of security group ids when Lambda Function should run in the VPC."
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}

variable "container_image_uri" {
  description = "The URI of a container image in the Amazon ECR registry"
  type        = string
}

variable "create_cloudwatch_log_group" {
  description = "Whether to use an existing CloudWatch log group or create new"
  type        = bool
  default     = false
}

variable "cloudwatch_logs_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
  type        = number
  default     = 90
}

variable "cloudwatch_logs_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data."
  type        = string
  default     = null
}

variable "architectures" {
  description = "List of architecture, valid values are x86_64 and arm64."
  type        = list(string)
  default     = null
}