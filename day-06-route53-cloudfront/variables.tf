# Day 6: Input Variables for DNS & CDN Configuration
# Professional configuration management

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "learning"
}

variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
  default     = "terraform-learning-journey"
}