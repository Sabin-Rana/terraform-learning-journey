# main.tf - Day 4: Lambda + CloudWatch + Serverless
# This configuration creates AWS Lambda functions with IAM roles,
# CloudWatch logging, and demonstrates serverless architecture

# Terraform configuration block
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

# AWS Provider configuration
provider "aws" {
  region = "us-east-1"
}

# IAM Role for Lambda execution
resource "aws_iam_role" "lambda_role" {
  name = "day4_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Project = "terraform-day4"
  }
}

# Attach basic Lambda execution policy for CloudWatch logs
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Zip archive for Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda_function/lambda.py"
  output_path = "lambda_function_payload.zip"
}

# AWS Lambda function
resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda_function_payload.zip"
  function_name    = "day4_hello_terraform"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      environment = "production"
      project     = "terraform-day4"
    }
  }

  tags = {
    Project = "terraform-day4"
  }
}