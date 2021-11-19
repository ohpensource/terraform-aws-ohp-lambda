# Usage (example 1 - create function without new role creation with local .zip. no vpc)

module "lambda_function" {
  source                            = "git::https://bitbucket.org/ohpen-dev/terraform-aws-ohp-lambda.git"
  create_function                   = true                                                        #Set to true to create lambda function
  role_name                         = "arn:aws:iam::720578572654:role/service-role/existing_role" # Exisiting Role name for the function
  function_name                     = "function_name"
  handler                           = "testscript.lambda_handler"
  runtime                           = "python3.7"
  memory_size                       = 256                                                  #default is 128
  timeout                           = 5                                                    #default is 3
  tracing_mode                      = "Active"                                             # (Optional. Options are Active or PassThrough. Default is Null
  reserved_concurrent_executions    = 5                                                    # Default is -1 (disabled)
  create_cloudwatch_log_group       = true                                                 # Create Log for the function
  cloudwatch_logs_retention_in_days = 30                                                   # Default is 90
  cloudwatch_logs_kms_key_id        = "arn:aws:kms:eu-west-1:0611111111:key/1232432435435" #default is Null
  local_existing_package            = "../scripts/testscript.zip"                          # Optional to specify local location of .zip lambda function

  environment_variables = {
    Serverless = "Terraform" #Optional Env Vars
  }

  tags = {
    Terraform   = "true"
    Environment = "default"
    Account_ID  = data.aws_caller_identity.current.account_id # Tags example
    Created_by  = data.aws_caller_identity.current.arn
  }
}




