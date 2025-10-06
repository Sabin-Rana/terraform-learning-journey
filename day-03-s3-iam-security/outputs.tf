# outputs.tf - Day 3: S3 Storage + IAM Security

output "s3_bucket_name" {
  description = "The name of the S3 bucket created"
  value       = aws_s3_bucket.static_website.bucket
}

output "s3_bucket_website_endpoint" {
  description = "The website endpoint for the S3 static website"
  value       = aws_s3_bucket_website_configuration.static_website.website_endpoint
}

output "iam_role_name" {
  description = "The name of the IAM role created"
  value       = aws_iam_role.s3_read_only_role.name
}

output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "static_website_url" {
  description = "The URL to access the static website"
  value       = "http://${aws_s3_bucket_website_configuration.static_website.website_endpoint}"
}