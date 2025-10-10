# Day 6: Output Values for DNS & CDN Resources
# Provides essential connection and configuration information

output "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.learning_cdn.domain_name
}

output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.learning_cdn.id
}

output "route53_zone_id" {
  description = "ID of the Route53 hosted zone"
  value       = aws_route53_zone.learning_zone.zone_id
}

output "route53_name_servers" {
  description = "Name servers for the Route53 hosted zone"
  value       = aws_route53_zone.learning_zone.name_servers
}

output "acm_certificate_arn" {
  description = "ARN of the ACM SSL certificate"
  value       = aws_acm_certificate.ssl_certificate.arn
}

output "random_domain_suffix" {
  description = "Random suffix used for domain names"
  value       = random_pet.domain_suffix.id
}