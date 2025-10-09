# Day 5: Output Values for Database Resources
# Provides structured access to resource attributes

output "dynamodb_table_name" {
  description = "Name of the created DynamoDB table"
  value       = aws_dynamodb_table.learning_db.name
}

output "dynamodb_table_arn" {
  description = "Amazon Resource Name (ARN) of the DynamoDB table"
  value       = aws_dynamodb_table.learning_db.arn
}

output "dynamodb_table_id" {
  description = "Unique identifier of the DynamoDB table"
  value       = aws_dynamodb_table.learning_db.id
}

# RDS Configuration Outputs (Commented - for learning purposes only)
/*
output "rds_endpoint" {
  description = "Connection endpoint for the RDS instance"
  value       = aws_db_instance.mysql_database[0].endpoint
  sensitive   = true
}

output "rds_availability_zone" {
  description = "Availability zone where RDS instance is deployed"
  value       = aws_db_instance.mysql_database[0].availability_zone
}
*/