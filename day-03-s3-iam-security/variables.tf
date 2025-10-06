# variables.tf - Day 3: S3 Storage + IAM Security

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "website_index_document" {
  description = "The name of the index document for the website"
  type        = string
  default     = "index.html"
}

variable "website_error_document" {
  description = "The name of the error document for the website"
  type        = string
  default     = "error.html"
}
