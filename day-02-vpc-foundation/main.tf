# main.tf - Day 2: VPC Foundation
# This configuration creates a complete VPC infrastructure with public subnets,
# internet connectivity, and a web server running Apache.

# Terraform configuration block
# Specifies the minimum Terraform version and required providers
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider configuration
# Defines the AWS region where resources will be created
provider "aws" {
  region = "us-east-2"
}

# VPC Resource
# Creates the main Virtual Private Cloud with DNS support enabled
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  # Enable DNS resolution and hostnames for the VPC
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "main-learning-vpc"
    Project = "terraform-day2"
  }
}

# Internet Gateway
# Provides internet connectivity for resources in the VPC
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main-internet-gateway"
  }
}

# Public Subnet 1
# First public subnet in availability zone us-east-2a
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  # Automatically assign public IP addresses to instances launched in this subnet
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
    Type = "Public"
  }
}

# Public Subnet 2
# Second public subnet in availability zone us-east-2b for high availability
resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"

  # Automatically assign public IP addresses to instances launched in this subnet
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
    Type = "Public"
  }
}

# Public Route Table
# Routes internet-bound traffic to the Internet Gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  # Route all outbound traffic (0.0.0.0/0) to the Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Route Table Association for Public Subnet 1
# Associates the public route table with the first public subnet
resource "aws_route_table_association" "public_1_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Route Table Association for Public Subnet 2
# Associates the public route table with the second public subnet
resource "aws_route_table_association" "public_2_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group for Web Server
# Allows HTTP (port 80) and SSH (port 22) inbound traffic
resource "aws_security_group" "web_sg" {
  name        = "web-security-group"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.main_vpc.id

  # Allow SSH access from anywhere
  # Note: In production, restrict this to specific IP addresses
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-security-group"
  }
}

# EC2 Instance - Web Server
# Creates an EC2 instance in the custom VPC with Apache web server
resource "aws_instance" "web_server" {
  ami           = "ami-0b1dcb5abc47cd8b5"
  instance_type = "t2.micro"

  # Place instance in the first public subnet
  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # User data script to install and configure Apache web server
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform Day 2!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name    = "web-server-in-custom-vpc"
    Project = "terraform-day2"
  }
}