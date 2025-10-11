# Day 7: Input Variables for State Management
# Professional configuration management

variable "aws_region" {
  description = "AWS region for state management resources"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "learning"
  validation {
    condition     = contains(["learning", "development", "staging", "production"], var.environment)
    error_message = "Environment must be learning, development, staging, or production."
  }
}

variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
  default     = "terraform-learning-journey"
}