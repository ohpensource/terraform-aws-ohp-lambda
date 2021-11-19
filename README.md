# MIGRATED TO GITHUB
This module can be pulled directly from github. Update source to

"github.com/ohpensource/terraform-aws-ohp-lambda?ref=v0.0.1"

Check GitHub for latest version number

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_logs_kms_key_id"></a> [cloudwatch\_logs\_kms\_key\_id](#input\_cloudwatch\_logs\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data. | `string` | `null` | no |       
| <a name="input_cloudwatch_logs_retention_in_days"></a> [cloudwatch\_logs\_retention\_in\_days](#input\_cloudwatch\_logs\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. | `number` | `90` | no |
| <a name="input_cloudwatch_tags"></a> [cloudwatch\_tags](#input\_cloudwatch\_tags) | A map of tags to assign to cloudwatch log | `map(string)` | `{}` | no |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Whether to use an existing CloudWatch log group or create new | `bool` | `false` | no | 
| <a name="input_create_function"></a> [create\_function](#input\_create\_function) | Controls whether Lambda Function resource should be created | `bool` | `true` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Controls whether Lambda Function IAM Role is created | `bool` | `false` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | A map that defines environment variables for the Lambda Function. | `map(string)` | `{}` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | A unique name for your Lambda Function | `string` | `""` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Lambda Function entrypoint in your code | `string` | `""` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN of KMS key to use by your Lambda Function | `string` | `null` | no |
| <a name="input_lambda_role"></a> [lambda\_role](#input\_lambda\_role) | IAM role ARN attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details. | `string` | `""` | no |
| <a name="input_lambda_tags"></a> [lambda\_tags](#input\_lambda\_tags) | A map of tags to assign to the Lambda Function | `map(string)` | `{}` | no |
| <a name="input_local_existing_package"></a> [local\_existing\_package](#input\_local\_existing\_package) | The absolute path to an existing zip-file to use | `string` | `null` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Amount of memory in MB your Lambda Function can use at runtime. Valid value between 128 MB to 10,240 MB (10 GB), in 64 MB increments. | `number` | `128` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | The amount of reserved concurrent executions for this Lambda Function. A value of 0 disables Lambda Function from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. | `number` | `-1` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of IAM role to use for Lambda Function | `string` | `null` | no |
| <a name="input_role_tags"></a> [role\_tags](#input\_role\_tags) | A map of tags to assign to IAM role | `map(string)` | `{}` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda Function runtime | `string` | `""` | no |
| <a name="input_s3_existing_package"></a> [s3\_existing\_package](#input\_s3\_existing\_package) | The S3 bucket object with keys bucket, key pointing to an existing zip-file to use | `map(string)` | `null` | no || <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The amount of time your Lambda Function has to run in seconds. | `number` | `5` | no |
| <a name="input_tracing_mode"></a> [tracing\_mode](#input\_tracing\_mode) | Tracing mode of the Lambda Function. Valid value can be either PassThrough or Active. | `string` | `null` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of security group ids when Lambda Function should run in the VPC. | `list(string)` | `null` | no || <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | List of subnet ids when Lambda Function should run in the VPC. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_cloudwatch_log_group_arn"></a> [lambda\_cloudwatch\_log\_group\_arn](#output\_lambda\_cloudwatch\_log\_group\_arn) | The ARN of the Cloudwatch Log Group |
| <a name="output_lambda_cloudwatch_log_group_name"></a> [lambda\_cloudwatch\_log\_group\_name](#output\_lambda\_cloudwatch\_log\_group\_name) | The name of the Cloudwatch Log Group |
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda Function |
| <a name="output_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#output\_lambda\_function\_invoke\_arn) | The Invoke ARN of the Lambda Function |
| <a name="output_lambda_function_kms_key_arn"></a> [lambda\_function\_kms\_key\_arn](#output\_lambda\_function\_kms\_key\_arn) | The ARN for the KMS encryption key of Lambda Function |
| <a name="output_lambda_function_last_modified"></a> [lambda\_function\_last\_modified](#output\_lambda\_function\_last\_modified) | The date Lambda Function resource was last modified |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the Lambda Function |
| <a name="output_lambda_function_qualified_arn"></a> [lambda\_function\_qualified\_arn](#output\_lambda\_function\_qualified\_arn) | The ARN identifying your Lambda Function Version |
| <a name="output_lambda_function_source_code_hash"></a> [lambda\_function\_source\_code\_hash](#output\_lambda\_function\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file |   
| <a name="output_lambda_function_source_code_size"></a> [lambda\_function\_source\_code\_size](#output\_lambda\_function\_source\_code\_size) | The size in bytes of the function .zip file |
| <a name="output_lambda_function_version"></a> [lambda\_function\_version](#output\_lambda\_function\_version) | Latest published version of Lambda Function |
| <a name="output_lambda_role_arn"></a> [lambda\_role\_arn](#output\_lambda\_role\_arn) | The ARN of the IAM role created for the Lambda Function |
| <a name="output_lambda_role_name"></a> [lambda\_role\_name](#output\_lambda\_role\_name) | The name of the IAM role created for the Lambda Function 

## Usage (example 1 - create function without new role creation with local .zip. no vpc)

    module "lambda_function" {
    source                            = "git::https://bitbucket.org/ohpen-dev/terraform-aws-ohp-lambda.git"
    create_function                   = true        #Set to true to create lambda function
    role_name                         = "arn:aws:iam::720578572654:role/service-role/existing_role" # Exisiting Role name for the function
    function_name                     = "function_name"
    handler                           = "testscript.lambda_handler"
    runtime                           = "python3.7"
    memory_size                       = 256         #default is 128
    timeout                           = 5           #default is 3
    tracing_mode                      = "Active"    # (Optional. Options are Active or PassThrough. Default is Null
    reserved_concurrent_executions    = 5           # Default is -1 (disabled)
    create_cloudwatch_log_group       = true        # Create Log for the function
    cloudwatch_logs_retention_in_days = 30          # Default is 90
    cloudwatch_logs_kms_key_id  	  = "arn:aws:kms:eu-west-1:0611111111:key/1232432435435" #default is Null
    local_existing_package = "../scripts/testscript.zip"  # Optional to specify local location of .zip lambda function
    
    environment_variables = {
        Serverless = "Terraform"				#Optional Env Vars
        }
    
    tags = {
      Terraform = "true"
      Environment = "default"
      Account_ID = data.aws_caller_identity.current.account_id		# Tags example
      Created_by = data.aws_caller_identity.current.arn
    }
  }

    (example 2 - create function without new role creation with s3 bucket .zip. In vpc) 

    module "lambda_function" {
    source                            = "git::https://bitbucket.org/ohpen-dev/terraform-aws-ohp-lambda.git"
    create_function                   = true        #Set to true to create lambda function
    role_name                         = "arn:aws:iam::720578572654:role/service-role/existing_role" # Exisiting Role name for the function
    function_name                     = "function_name"
    handler                           = "testscript.lambda_handler"
    runtime                           = "python3.7"
    memory_size                       = 256         #default is 128
    timeout                           = 5           #default is 3
    tracing_mode                      = "Active"    # (Optional. Options are Active or PassThrough. Default is Null
    reserved_concurrent_executions    = 5           # Default is -1 (disabled)
    create_cloudwatch_log_group       = true        # Create Log for the function
    cloudwatch_logs_retention_in_days = 30          # Default is 90
    cloudwatch_logs_kms_key_id  	  = "arn:aws:kms:eu-west-1:0611111111:key/1232432435435" #default is Null

    environment_variables = {
        Serverless = "Terraform"				    #Optional Env Vars
        }

    s3_existing_package = {						
        bucket = "bucketcode"				        # Optional to specify s3 bucket and key where .zip lambda function is located
        key    = "testscript.zip"
        }
  
    vpc_security_group_ids    = ["sg-04c82e608d1df0983"]			                        # set if Lambda is running in a vpc
    vpc_subnet_ids            = ["subnet-058900279835c8912", "subnet-0346e51de23da20c3"]  # set if Lambda is running in a vpc
    tags = {
      Terraform = "true"
      Environment = "default"
      Account_ID = data.aws_caller_identity.current.account_id		# Tags example
      Created_by = data.aws_caller_identity.current.arn
     }
	}

    (example 3 - create function with new role creation with s3 bucket .zip. In vpc) 

    module "lambda_function" {
    source                            = "git::https://bitbucket.org/ohpen-dev/terraform-aws-ohp-lambda.git"
    create_function                   = true            #Set to true to create lambda function
    create_role                       = true            #optional setting to create role. Creates the polices for the various options (s3/cloudwatch/assume_role).    function_name                     = "function_name"
    function_name                     = "function_name"
	handler                           = "testscript.lambda_handler"
    runtime                           = "python3.7"
    memory_size                       = 256             #default is 128
    timeout                           = 5               #default is 3
    tracing_mode                      = "Active"        # (Optional. Options are Active or PassThrough. Default is Null
    reserved_concurrent_executions    = 5               # Default is -1 (disabled)
    create_cloudwatch_log_group       = true            # Create Log for the function. 
    cloudwatch_logs_retention_in_days = 30              # Default is 90
    cloudwatch_logs_kms_key_id  	  = "arn:aws:kms:eu-west-1:0611111111:key/1232432435435" #default is Null
    
    environment_variables = {
        Serverless = "Terraform"				#Optional Env Vars
        }

    s3_existing_package = {						
        bucket = "bucketcode"				    # Optional to specify s3 bucket and key where .zip lambda function is located
        key    = "testscript.zip"
        }
  
    vpc_security_group_ids    = ["sg-04c82e608d1df0983"]			                        # Optional to set if Lambda is running in a vpc
    vpc_subnet_ids            = ["subnet-058900279835c8912", "subnet-0346e51de23da20c3"]  # Optional to set if Lambda is running in a vpc
    tags = {
      Terraform = "true"
      Environment = "default"
      Account_ID = data.aws_caller_identity.current.account_id		# Tags example
      Created_by = data.aws_caller_identity.current.arn
     }
	}