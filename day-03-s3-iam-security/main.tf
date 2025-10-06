# main.tf - Day 3: S3 Storage + IAM Security
# This configuration creates S3 buckets with static website hosting,
# IAM roles and policies, and demonstrates JSON encoding

# Terraform configuration block
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

# AWS Provider configuration
provider "aws" {
  region = "us-east-2"
}

# Random provider for unique bucket names
resource "random_pet" "bucket_name" {
  length    = 2
  separator = "-"
}

# S3 Bucket for Static Website Hosting
resource "aws_s3_bucket" "static_website" {
  bucket = "${random_pet.bucket_name.id}-static-website"

  tags = {
    Name    = "static-website-bucket"
    Project = "terraform-day3"
  }
}

# S3 Bucket Ownership Controls
resource "aws_s3_bucket_ownership_controls" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# S3 Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 Bucket ACL for Public Read
resource "aws_s3_bucket_acl" "static_website" {
  depends_on = [
    aws_s3_bucket_ownership_controls.static_website,
    aws_s3_bucket_public_access_block.static_website,
  ]

  bucket = aws_s3_bucket.static_website.id
  acl    = "public-read"
}

# S3 Bucket Website Configuration
resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# S3 Bucket Policy for Public Read Access
resource "aws_s3_bucket_policy" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_website.arn}/*"
      },
    ]
  })
}

# Upload index.html to S3 bucket
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  content      = <<EOF
<html>
<head>
    <title>Terraform Day 3 - S3 Static Website</title>
</head>
<body>
    <h1>Hello from Terraform Day 3!</h1>
    <p>This is a static website hosted on S3</p>
    <p>Bucket: ${aws_s3_bucket.static_website.bucket}</p>
</body>
</html>
EOF
  content_type = "text/html"
}

# Upload error.html to S3 bucket
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "error.html"
  content      = <<EOF
<html>
<head>
    <title>Error - Terraform Day 3</title>
</head>
<body>
    <h1>Oops! Something went wrong</h1>
    <p>This is the error page for our S3 static website</p>
</body>
</html>
EOF
  content_type = "text/html"
}

# IAM Role for EC2 Instances
resource "aws_iam_role" "s3_read_only_role" {
  name = "s3-read-only-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Project = "terraform-day3"
  }
}

# IAM Policy for S3 Read Only Access
resource "aws_iam_policy" "s3_read_only" {
  name        = "s3-read-only-policy"
  description = "Allows read-only access to S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.static_website.arn,
          "${aws_s3_bucket.static_website.arn}/*"
        ]
      },
    ]
  })
}

# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "s3_read_only_attach" {
  role       = aws_iam_role.s3_read_only_role.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "s3_read_only_profile" {
  name = "s3-read-only-instance-profile"
  role = aws_iam_role.s3_read_only_role.name
}

# Security Group for Web Server
resource "aws_security_group" "web_sg" {
  name        = "web-security-group-day3"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "terraform-day3"
  }
}

# EC2 Instance with IAM Instance Profile
resource "aws_instance" "web_server" {
  ami           = "ami-0b1dcb5abc47cd8b5"
  instance_type = "t2.micro"

  # Attach IAM instance profile for S3 access
  iam_instance_profile = aws_iam_instance_profile.s3_read_only_profile.name

  # User data script that demonstrates S3 access
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              
              # Create a simple webpage that mentions S3 access
              echo "<h1>Hello from Terraform Day 3!</h1>" > /var/www/html/index.html
              echo "<p>This EC2 instance has IAM role: s3-read-only-role</p>" >> /var/www/html/index.html
              echo "<p>It can access S3 bucket: ${aws_s3_bucket.static_website.bucket}</p>" >> /var/www/html/index.html
              EOF

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name    = "web-server-with-s3-access"
    Project = "terraform-day3"
  }
}