# S3 Static Website Module
# Reusable component for static website hosting

resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

#resource "aws_s3_bucket_acl" "website" {
 # bucket = aws_s3_bucket.website.id
  #acl    = "public-read"
#} 

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  content      = <<EOF
<html>
  <body>
    <h1>Welcome to ${var.bucket_name}</h1>
    <p>This is a static website hosted by Terraform!</p>
  </body>
</html>
EOF
  content_type = "text/html"
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false  # Allow public ACLs for website
  block_public_policy     = false  # Allow public bucket policies
  ignore_public_acls      = false
  restrict_public_buckets = false
}