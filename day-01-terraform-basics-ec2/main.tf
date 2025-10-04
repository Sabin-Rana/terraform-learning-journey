# main.tf - Day 01: Terraform Basics and EC2 Instance Creation

# Configure Terraform version and required providers
# Ensures consistent behavior across different environments
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Allows minor version updates within 5.x
    }
  }
}

# Configure AWS provider
# Specifies the region where resources will be provisioned
provider "aws" {
  region = "us-east-2"
}

# Provision EC2 instance for learning basic Terraform resource management
# Uses free-tier eligible t2.micro instance type
resource "aws_instance" "my_first_server" {
  ami           = "ami-0b1dcb5abc47cd8b5"  # Amazon Linux 2023 AMI for us-east-2
  instance_type = "t2.micro"                # 1 vCPU, 1 GB RAM -> free tier eligible
  
  # Allow termination via Terraform destroy command
  disable_api_termination = false
  
  # Resource tags for identification and cost tracking
  tags = {
    Name    = "My-First-Terraform-Server"
    Project = "Terraform-Learning-Day1"
    Owner   = "Sabin-Rana"
  }
}