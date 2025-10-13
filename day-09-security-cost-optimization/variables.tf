# Day 9: Input Variables for Security and Cost Optimization
# Environment-specific secure configurations

variable "aws_region" {
  description = "AWS region for secure deployment"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Deployment environment for security tagging"
  type        = string
  default     = "security-demo"
  
  validation {
    condition     = contains(["security-demo", "development", "staging", "production"], var.environment)
    error_message = "Environment must be security-demo, development, staging, or production."
  }
}

variable "project_name" {
  description = "Project name for resource tagging and cost tracking"
  type        = string
  default     = "terraform-security-cost-demo"
}

variable "enable_cost_monitoring" {
  description = "Whether to enable cost estimation and monitoring features"
  type        = bool
  default     = true
}

variable "security_level" {
  description = "Security level for infrastructure (basic, standard, high)"
  type        = string
  default     = "standard"
  
  validation {
    condition     = contains(["basic", "standard", "high"], var.security_level)
    error_message = "Security level must be basic, standard, or high."
  }
}