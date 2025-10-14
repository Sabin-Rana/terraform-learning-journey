# Day 10: Advanced Variable Patterns
# Complex variable types and validation

# Advanced: Complex Object Variable
variable "project_config" {
  description = "Advanced project configuration using object type"
  type = object({
    name        = string
    environment = string
    owner       = string
    cost_center = string
    tier        = string
  })
  default = {
    name        = "advanced-demo"
    environment = "development"
    owner       = "learning-team"
    cost_center = "training"
    tier        = "standard"
  }
}

# Advanced: Map Variable with Validation
variable "environment_configs" {
  description = "Configuration settings per environment"
  type = map(object({
    instance_type = string
    min_size      = number
    max_size      = number
    enable_backup = bool
  }))
  default = {
    development = {
      instance_type = "t3.micro"
      min_size      = 1
      max_size      = 2
      enable_backup = false
    }
    staging = {
      instance_type = "t3.small"
      min_size      = 1
      max_size      = 3
      enable_backup = true
    }
    production = {
      instance_type = "t3.medium"
      min_size      = 2
      max_size      = 5
      enable_backup = true
    }
  }
}

# Advanced: List Variable with Validation
variable "web_ports" {
  description = "List of web ports to open"
  type        = list(number)
  default     = [80, 443, 8080]

  validation {
    condition = alltrue([
      for port in var.web_ports : port > 0 && port < 65535
    ])
    error_message = "All ports must be between 1 and 65535."
  }
}

# Advanced: Conditional Default Values
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "development"

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be development, staging, or production."
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "day10-advanced"
}

variable "owner" {
  description = "Resource owner"
  type        = string
  default     = "terraform-learning"
}

variable "cost_center" {
  description = "Cost center for billing"
  type        = string
  default     = "training"
}

# Advanced: Boolean with Sensible Default
variable "create_vpc" {
  description = "Whether to create VPC resources"
  type        = bool
  default     = true
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "Must be a valid CIDR block."
  }
}

# Advanced: Sensitive Variable (simulated)
variable "db_password" {
  description = "Database password (would be sensitive in real scenario)"
  type        = string
  default     = "dummy-password-for-learning"
  sensitive   = true
}