variable "bucket_name" {
  description = "Name of the S3 bucket for the website"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "development"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraform-module"
}
