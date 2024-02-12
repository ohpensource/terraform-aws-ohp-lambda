# Terraform Module - Template

[![license](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/ohpensource/terraform-aws-ohp-lambda/continuous-delivery)

![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/ohpensource/terraform-aws-ohp-lambda)

## Maintainer

* Platform Services

## Description

AWS Lambda module for deploying a lambda function.

## Modules

* standard

```hcl
module "trans_union_stub" {
  source                      = "git::https://github.com/ohpensource/terraform-aws-ohp-lambda.git//modules//standard?ref=v0.1.5"
  create_role                 = true
  function_name               = "${local.resource_name_prefix}-trans-union-stub-${var.deployment}"
  handler                     = "com.ohpen.close.kyc.stubs.transunion.TransUnionStub"
  runtime                     = local.default_java_runtime
  timeout                     = local.default_timeout
  create_cloudwatch_log_group = true
  memory_size                 = local.default_memory_size
  snap_start                  = true

  s3_existing_package = {
    bucket = local.artifacts_bucket
    key    = "${local.artifact_key_prefix}/close-kyc-stubs-trans-union/${local.software_version}/close-kyc-stubs-trans-union-${local.software_version}.jar"
  }

  tags = {
    ServiceVersion = var.software_version
    Component      = "trans-union-stub"
  }

  vpc_subnet_ids         = local.vpc_subnet_ids
  vpc_security_group_ids = [aws_security_group.default.id]

  environment_variables = {
    stage             = var.stage
    domain            = local.domain
    deployment        = var.deployment
    JAVA_TOOL_OPTIONS = local.java_tools_options
  }
}
```

* container

```hcl
module "trans_union_stub" {
  source                      = "git::https://github.com/ohpensource/terraform-aws-ohp-lambda.git//modules//container?ref=v2.0.1"
  create_role                 = true
  function_name               = "${local.resource_name_prefix}-my-lambda"

  timeout                     = local.default_timeout
  create_cloudwatch_log_group = true
  memory_size                 = local.default_memory_size

  container_image_uri = "111111111111111.dkr.ecr.eu-west-1.amazonaws.com/project/module:latest"

  tags = {
    ServiceVersion = var.software_version
    Component      = "trans-union-stub"
  }

  vpc_subnet_ids         = local.vpc_subnet_ids
  vpc_security_group_ids = [aws_security_group.default.id]

  environment_variables = {
    stage             = var.stage
    domain            = local.domain
    deployment        = var.deployment
    JAVA_TOOL_OPTIONS = local.java_tools_options
  }
}
```
