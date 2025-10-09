# Day 5: Input Variables for Database Configuration
# Centralized configuration management

variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-east-2" # Changed to Ohio
}

variable "environment" {
  description = "Deployment environment (development, staging, production)"
  type        = string
  default     = "development"
  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be development, staging, or production."
  }
}

variable "project_name" {
  description = "Name of the project for resource tagging"
  type        = string
  default     = "terraform-learning-journey"
}