# Day 8: Output Values for CI/CD Pipeline
# Provides essential information for automation

output "s3_bucket_name" {
  description = "Name of the CI/CD demo bucket for pipeline use"
  value       = aws_s3_bucket.ci_cd_bucket.bucket
  sensitive   = false
}

output "s3_bucket_region" {
  description = "Region where the bucket was deployed"
  value       = var.aws_region
}

output "current_environment" {
  description = "Active deployment environment"
  value       = var.environment
}

output "deployment_summary" {
  description = "Summary of the CI/CD deployment"
  value       = "CI/CD demo deployed to ${var.environment} in ${var.aws_region}"
}
