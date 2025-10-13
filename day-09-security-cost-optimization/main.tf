# Day 9: Security Best Practices + Cost Optimization
# Learning secure infrastructure patterns and cost control

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Secure S3 Bucket with proper security settings
resource "aws_s3_bucket" "secure_data" {
  bucket = "secure-data-${var.environment}-${random_pet.bucket_suffix.id}"

  tags = {
    Name        = "secure-data-${var.environment}"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Block ALL public access to the bucket (Security Best Practice)
resource "aws_s3_bucket_public_access_block" "secure_data" {
  bucket = aws_s3_bucket.secure_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning for data recovery (Security Best Practice)
resource "aws_s3_bucket_versioning" "secure_data" {
  bucket = aws_s3_bucket.secure_data.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Serverless Lambda function (Cost Optimization - pay per use)
resource "aws_lambda_function" "security_scanner" {
  filename      = "lambda_function_payload.zip"
  function_name = "security-scanner-${var.environment}"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "python3.9"

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# IAM Role for Lambda (Security Principle of Least Privilege)
resource "aws_iam_role" "lambda_role" {
  name = "lambda-security-role-${var.environment}"

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
    Environment = var.environment
    Project     = var.project_name
  }
}

# Random name generator for unique resource names
resource "random_pet" "bucket_suffix" {
  length = 2
}
