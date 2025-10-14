# Day 10: Advanced Terraform Patterns
# Learning complex module structures and state management

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Advanced: Remote State Configuration (Production Practice)
  #backend "s3" {
  # We'll simulate this - real values would be in backend.tf
  #bucket = "terraform-state-advanced-demo"
  #key    = "day-10/terraform.tfstate"
  # region = "us-east-2"
  # encrypt = true (commented for learning)
  #}
}

provider "aws" {
  region = var.aws_region
}

# Advanced: Data Sources for Dynamic Configuration
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Advanced: Local Values for Complex Calculations
locals {
  project_prefix = "${var.project_name}-${var.environment}"
  az_names       = slice(data.aws_availability_zones.available.names, 0, 2)

  # Advanced: Conditional values based on environment
  instance_type  = var.environment == "production" ? "t3.medium" : "t3.micro"
  instance_count = var.environment == "production" ? 2 : 1

  # Advanced: Complex tags
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = var.owner
    CostCenter  = var.cost_center
  }
}

# Advanced: Count and For-Each Patterns
resource "aws_vpc" "main" {
  count = var.create_vpc ? 1 : 0

  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name = "${local.project_prefix}-vpc"
  })
}

# Advanced: Dynamic Blocks for Security Groups
resource "aws_security_group" "web" {
  name_prefix = "${local.project_prefix}-web-"
  vpc_id      = var.create_vpc ? aws_vpc.main[0].id : null

  # Dynamic ingress block
  dynamic "ingress" {
    for_each = var.web_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

# Advanced: Conditional Creation with Count
resource "aws_instance" "web_servers" {
  count = local.instance_count

  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = local.instance_type
  subnet_id     = var.create_vpc ? values(aws_subnet.public)[count.index].id : null

  vpc_security_group_ids = [aws_security_group.web.id]

  tags = merge(local.common_tags, {
    Name = "${local.project_prefix}-web-${count.index + 1}"
  })

  # Advanced: Lifecycle Configuration
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [ami] # Don't auto-update AMI
  }
}

# Advanced: For-Each with Maps
resource "aws_subnet" "public" {
  for_each = var.create_vpc ? { for idx, az in local.az_names : az => idx } : {}

  vpc_id            = aws_vpc.main[0].id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value + 1)
  availability_zone = each.key

  tags = merge(local.common_tags, {
    Name = "${local.project_prefix}-public-${each.key}"
  })
}

# Advanced: Random Resources for Unique Naming
resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "logs" {
  bucket = "${local.project_prefix}-logs-${random_id.bucket_suffix.hex}"

  tags = local.common_tags

  # Advanced: Explicit Dependency
  depends_on = [
    aws_vpc.main
  ]
}