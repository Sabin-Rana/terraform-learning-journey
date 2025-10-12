# Day 8: Input Variables for CI/CD & Team Collaboration
# Environment-specific configurations

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Deployment environment (uses Terraform workspace)"
  type        = string
  default     = "development"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-ci-cd-demo"
}

variable "enable_cost_estimation" {
  description = "Whether to enable cost estimation features"
  type        = bool
  default     = true
}
