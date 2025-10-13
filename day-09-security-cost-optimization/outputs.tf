# Day 9: Output Values for Security and Cost Monitoring
# Critical information for security audits and cost tracking

output "secure_bucket_name" {
  description = "Name of the securely configured S3 bucket"
  value       = aws_s3_bucket.secure_data.bucket
  sensitive   = false
}

output "secure_bucket_arn" {
  description = "ARN of the secure S3 bucket for IAM policies"
  value       = aws_s3_bucket.secure_data.arn
}

output "lambda_function_name" {
  description = "Name of the cost-optimized Lambda function"
  value       = aws_lambda_function.security_scanner.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function for security monitoring"
  value       = aws_lambda_function.security_scanner.arn
}

output "security_summary" {
  description = "Summary of security configurations applied"
  value       = "S3 Public Access: BLOCKED | Versioning: ENABLED | Security Level: ${var.security_level}"
}

output "cost_optimization_features" {
  description = "Cost optimization features enabled"
  value       = var.enable_cost_monitoring ? "Cost monitoring ENABLED" : "Cost monitoring DISABLED"
}