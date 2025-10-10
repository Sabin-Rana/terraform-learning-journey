# Day 6: Route53 DNS + CloudFront CDN + ACM SSL Certificates
# Terraform Learning Journey - Professional Configuration

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
  region = "us-east-2" # Ohio region
}

# Random provider for unique domain names
resource "random_pet" "domain_suffix" {
  length    = 2
  separator = "-"
}

# ACM Certificate - SSL/TLS Certificate (FREE)
resource "aws_acm_certificate" "ssl_certificate" {
  domain_name       = "learning-${random_pet.domain_suffix.id}.com"
  validation_method = "DNS"

  tags = {
    Name        = "day6-ssl-certificate"
    Environment = "learning"
    Project     = "terraform-learning-journey"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Route53 Hosted Zone - DNS Management
resource "aws_route53_zone" "learning_zone" {
  name = "learning-${random_pet.domain_suffix.id}.com"

  tags = {
    Name        = "day6-route53-zone"
    Environment = "learning"
    Project     = "terraform-learning-journey"
  }
}

# CloudFront Distribution - Content Delivery Network
resource "aws_cloudfront_distribution" "learning_cdn" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Day 6 Learning Distribution"
  default_root_object = "index.html"

  origin {
    domain_name = "aws.amazon.com" # Using AWS website as example origin
    origin_id   = "learning-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "learning-origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100" # US/Europe only - cheapest

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true # Use CloudFront default cert for learning
  }

  tags = {
    Name        = "day6-cloudfront-cdn"
    Environment = "learning"
    Project     = "terraform-learning-journey"
  }
}