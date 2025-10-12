# Day 8: CI/CD Integration + Team Collaboration
# Terraform Learning Journey - Professional CI/CD Patterns

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Simple S3 bucket for CI/CD demonstration
resource "aws_s3_bucket" "ci_cd_bucket" {
  bucket = "ci-cd-demo-${var.environment}-${random_pet.bucket_suffix.id}"

  tags = {
    Name        = "ci-cd-demo-${var.environment}"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "ci_cd_bucket" {
  bucket = aws_s3_bucket.ci_cd_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Random suffix for unique bucket names
resource "random_pet" "bucket_suffix" {
  length = 2
}


output "environment" {
  description = "Current workspace environment"
  value       = var.environment
}