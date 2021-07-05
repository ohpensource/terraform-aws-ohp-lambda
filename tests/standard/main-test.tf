variable "group" {
  description = "only variable to group resources under the same prefix"
  type        = string
  default     = "dev"
}

locals {
  name        = "ohp-lambda-${var.group}"
  account_id  = "215333367418"
  region      = "eu-west-1"
  environment = "int"

  tfm_x_acc_role_name = "xops-tfm-adm-x-acc-role"
  tfm_deploy_role_arn = "arn:aws:iam::${local.account_id}:role/${local.tfm_x_acc_role_name}-${local.environment}"
}

terraform {
  required_version = "~>0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~>2.0"
    }
  }
}

provider "aws" {
  region              = local.region
  allowed_account_ids = [local.account_id]
  assume_role {
    role_arn     = local.tfm_deploy_role_arn
    session_name = "terraform"
  }
}


module "lambda_function" {
  source          = "../../modules/standard"
  create_function = true #Set to true to create lambda function
  #role_name                         = 
  create_role                       = true #optional setting to create role. Creates the polices for the various options (s3/cloudwatch/assume_role).    function_name                     = "function_name"
  function_name                     = "Weather_API"
  handler                           = "lambda.lambda_handler"
  runtime                           = "python3.8"
  memory_size                       = 256                                                  #default is 128
  timeout                           = 5                                                    #default is 3
  tracing_mode                      = "Active"                                             #(Optional. Options are Active or PassThrough. Default is Null
  reserved_concurrent_executions    = 5                                                    #Default is -1 (disabled)
  create_cloudwatch_log_group       = true                                                 #Create Log for the function. 
  cloudwatch_logs_retention_in_days = 30                                                   #Default is 90
  cloudwatch_logs_kms_key_id        = "arn:aws:kms:eu-west-1:0611111111:key/1232432435435" #default is Null

  environment_variables = {
    Serverless = "Terraform" # Optional Env Vars
  }

  s3_existing_package = {
    bucket = "s3-code" #  Optional to specify s3 bucket and key where .zip lambda function is located
    key    = "code_lambda.zip"
  }

  vpc_security_group_ids = ["sg-04c82e608d1df0111"]                                 #   Optional to set if Lambda is running in a vpc
  vpc_subnet_ids         = ["subnet-058900279835c8111", "subnet-0346e51de23da2111"] # Optional to set if Lambda is running in a vpc
  tags = {
    Terraform   = "true"
    Environment = "default"
    #  Account_ID = data.aws_caller_identity.current.account_id       #Tags example
    #  Created_by = data.aws_caller_identity.current.arn
  }
}