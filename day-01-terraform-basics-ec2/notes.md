# Day 01: Terraform Basics and EC2 Instance Creation

**Date:**   October 4, 2025
**Duration:** 2 hours
**Status:** Completed

## Objectives

- Understand basic Terraform structure and syntax
- Learn about Terraform blocks, providers, and resources
- Deploy a simple EC2 instance on AWS
- Practice Terraform workflow: init, plan, apply, destroy

## What I Learned

### Core Concepts

**Terraform Block**
The terraform block is used to configure Terraform behavior itself, including required version and provider dependencies. This ensures that anyone using this configuration will have compatible tools.

**Provider Block**
Providers are plugins that allow Terraform to interact with cloud platforms, SaaS providers, and APIs. The AWS provider requires authentication credentials and a region specification.

**Resource Block**
Resources are the most important element in Terraform. They define infrastructure components to be created and managed. Each resource has a type and local name for reference.

### Terraform Workflow

1. terraform init - Initializes the working directory and downloads required providers
2. terraform plan - Creates an execution plan showing what changes will be made
3. terraform apply - Executes the planned changes and creates/modifies resources
4. terraform destroy - Removes all resources defined in the configuration

### AWS Concepts

**EC2 Instance**
Elastic Compute Cloud provides virtual servers in the cloud. Key parameters include AMI, instance type, and configuration options.

**AMI (Amazon Machine Image)**
AMIs are region-specific templates containing the operating system and pre-configured software. The same AMI ID will not work across different regions.

**Instance Types**
Define compute, memory, and networking capacity. The t2.micro instance provides 1 vCPU and 1 GB RAM, suitable for light workloads and testing.

**Tags**
Metadata attached to resources for identification, organization, and cost allocation. Tags are essential for managing resources at scale.

## Mistakes and Solutions

### Mistake 1: [Example - Region Mismatch]
Initially attempted to use an AMI ID from us-east-1 in us-east-2 region. Terraform returned an error stating the AMI could not be found.

**Solution:** Verified the AMI ID was specific to us-east-2 region. AMIs are region-locked and must match the provider region configuration.

### Mistake 2: [Example - Forgotten AWS Credentials]
Received authentication errors when running terraform plan.

**Solution:** Configured AWS credentials using AWS CLI with 'aws configure' command. Terraform automatically uses these credentials from the default profile.

### Mistake 3: [Example - State File Confusion]
Made manual changes to the EC2 instance in AWS console, causing state drift.

**Solution:** Learned that Terraform tracks infrastructure state in terraform.tfstate file. Manual changes should be avoided or imported into Terraform state. Used 'terraform refresh' to detect drift.

## Key Takeaways

- Terraform uses declarative syntax to define desired infrastructure state
- Always run terraform plan before apply to review changes
- The terraform.tfstate file is critical and should be protected
- Resources should be managed exclusively through Terraform once created
- Provider credentials must be configured before running Terraform commands
- AMI IDs are region-specific and must match the configured region

## Commands Used

```bash
# Initialize Terraform working directory
terraform init

# Validate configuration syntax
terraform validate

# Format code to canonical style
terraform fmt

# Preview changes without applying
terraform plan

# Apply changes and create resources
terraform apply

# Show current state
terraform show

# Destroy all managed infrastructure
terraform destroy
```

## Resources Referenced

- Terraform AWS Provider Documentation
- AWS EC2 Documentation
- Terraform Language Documentation

## Next Steps

- Explore variables and input parameters
- Learn about output values
- Understand remote state management
- Practice with multiple resource types

## Notes for Future Reference

- Always use version constraints for providers to ensure reproducibility
- Consider using terraform.tfvars for sensitive values instead of hardcoding
- Implement remote state backend for team collaboration
- Use consistent naming conventions for resources and tags