# Day 7: Advanced Modules + State Management
# Terraform Learning Journey - Professional Configuration

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # S3 Backend Configuration - Remote State Management
  # backend "s3" {
  # This will be configured after we create the S3 bucket
  # We'll update this section after initial deployment
  #}
}

provider "aws" {
  region = "us-east-2"
}

# S3 Bucket for Remote State Storage
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-${random_pet.bucket_name.id}"

  tags = {
    Name        = "Terraform State Storage"
    Environment = "learning"
    Project     = "terraform-learning-day7"
  }
}

# Enable versioning for state file recovery
resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks-${random_pet.bucket_name.id}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Locking"
    Environment = "learning"
    Project     = "terraform-learning-day7"
  }
}

# Random name for unique resource naming
resource "random_pet" "bucket_name" {
  length = 2
}

# Using our custom S3 website module
module "static_website" {
  source = "./modules/s3-website"

  bucket_name  = "my-website-${random_pet.bucket_name.id}"
  environment  = var.environment
  project_name = var.project_name
}