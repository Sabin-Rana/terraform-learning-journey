# Day 5: RDS Databases & Multi-Tier Architecture
# Terraform Learning Journey 
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
  region = "us-east-1"
}

# DynamoDB Table - NoSQL Database Implementation
# Using provisioned capacity within AWS Free Tier limits
resource "aws_dynamodb_table" "learning_db" {
  name           = "day5-learning-table-${formatdate("YYYYMMDD", timestamp())}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }

  tags = {
    Name        = "day5-dynamodb-database"
    Environment = "development"
    Project     = "terraform-learning-journey"
    Day         = "5"
  }
}

# RDS MySQL Database Configuration
# Demonstrates relational database setup with security best practices
# Note: count = 0 prevents actual creation for cost optimization
resource "aws_db_instance" "mysql_database" {
  identifier_prefix   = "day5-mysql-"
  allocated_storage   = 20
  storage_type       = "gp2"
  engine             = "mysql"
  engine_version     = "8.0"
  instance_class     = "db.t3.micro"
  username           = "admin"
  password           = "TempPassword123!" # In production, use AWS Secrets Manager
  publicly_accessible = false
  skip_final_snapshot = true

  tags = {
    Name        = "day5-mysql-database"
    Environment = "development"
    Project     = "terraform-learning-journey"
    Day         = "5"
  }

  # Configuration demonstration only - set count to 0 to prevent creation
  count = 0
}