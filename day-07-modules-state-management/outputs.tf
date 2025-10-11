# Day 7: Output Values for State Management
# Provides essential information for backend configuration

output "s3_bucket_name" {
  description = "Name of the S3 bucket for remote state storage"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  value       = aws_dynamodb_table.terraform_locks.name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 state bucket"
  value       = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB locking table"
  value       = aws_dynamodb_table.terraform_locks.arn
}