# Day 10: Advanced Output Patterns
# Complex outputs and data transformation

# Advanced: Complex Object Output
output "project_summary" {
  description = "Complete project summary as object"
  value = {
    project_name       = var.project_config.name
    environment        = var.project_config.environment
    vpc_created        = var.create_vpc
    instance_count     = local.instance_count
    instance_type      = local.instance_type
    availability_zones = local.az_names
  }
}

# Advanced: Conditional Output
output "vpc_id" {
  description = "VPC ID if created"
  value       = var.create_vpc ? aws_vpc.main[0].id : "VPC_NOT_CREATED"
  sensitive   = false
}

# Advanced: Output with For Loop
output "web_instance_details" {
  description = "Details of all web instances"
  value = [for instance in aws_instance.web_servers : {
    instance_id   = instance.id
    instance_type = instance.instance_type
    private_ip    = instance.private_ip
    az            = instance.availability_zone
    name          = instance.tags_all.Name
  }]
}

# Advanced: Map Output from For-Each
output "public_subnets" {
  description = "Map of public subnets"
  value = { for k, subnet in aws_subnet.public : k => {
    subnet_id  = subnet.id
    cidr_block = subnet.cidr_block
    az         = subnet.availability_zone
  } }
}

# Advanced: Filtered Output
output "web_security_group_rules" {
  description = "Ingress rules for web security group"
  value = [for rule in aws_security_group.web.ingress : {
    from_port   = rule.from_port
    to_port     = rule.to_port
    protocol    = rule.protocol
    description = rule.description
  }]
}

# Advanced: Formatted String Output
output "deployment_url" {
  description = "Formatted deployment information"
  value       = "Deployed ${local.instance_count} instances of type ${local.instance_type} in ${var.environment} environment"
}

# Advanced: Sensitive Output (simulated)
output "bucket_name" {
  description = "S3 bucket name for logs"
  value       = aws_s3_bucket.logs.bucket
  sensitive   = false # Would be true in production for certain buckets
}

# Advanced: Data Source Outputs
output "available_zones" {
  description = "Available AZs in region"
  value       = data.aws_availability_zones.available.names
}

output "latest_ami_id" {
  description = "Latest Amazon Linux AMI ID used"
  value       = data.aws_ami.latest_amazon_linux.id
}

# Advanced: Count-based Output
output "web_instances_by_index" {
  description = "Web instances with their index positions"
  value = { for i, instance in aws_instance.web_servers : i => {
    id   = instance.id
    name = instance.tags_all.Name
  } }
}

# Advanced: Complex Local Value Output
output "computed_configuration" {
  description = "Computed configuration values"
  value = {
    project_prefix     = local.project_prefix
    environment_config = var.environment_configs[var.environment]
    is_production      = var.environment == "production"
    total_azs_used     = length(local.az_names)
  }
}