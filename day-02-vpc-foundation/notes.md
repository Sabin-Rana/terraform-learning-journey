# Day 02: VPC Foundation - Learning Notes

## Day Information
- **Date:** October 5, 2025
- **Duration:** 2 hours
- **Topic:** VPC Foundation - Building Complete Network Infrastructure
- **Resources Created:** 9 AWS resources (VPC, IGW, 2 Subnets, Route Table, 2 Route Table Associations, Security Group, EC2)

---

## What I Learned Today (Terraform-Specific)

### 1. Creating VPC with Terraform
- Used `resource "aws_vpc"` block to define VPC in code
- Terraform parameters: `cidr_block`, `enable_dns_support`, `enable_dns_hostnames`
- Added `tags` block for naming and organization
- **Key Learning:** Infrastructure as code vs manual AWS Console creation

### 2. Attaching Internet Gateway to VPC in Terraform
- Used `resource "aws_internet_gateway"` block
- Connected IGW to VPC using `vpc_id = aws_vpc.main_vpc.id` reference
- **Key Learning:** How to reference one Terraform resource from another using resource_type.resource_name.attribute syntax

### 3. Creating Multiple Subnets with Terraform
- Defined two separate `resource "aws_subnet"` blocks
- Each subnet references parent VPC using `vpc_id = aws_vpc.main_vpc.id`
- Specified different `availability_zone` and `cidr_block` for each subnet
- **Key Learning:** How to create multiple instances of similar resources with different configurations

### 4. Configuring Route Tables in Terraform
- Used `resource "aws_route_table"` with nested `route` block
- Defined default route pointing to IGW: `gateway_id = aws_internet_gateway.main_igw.id`
- Created separate `aws_route_table_association` resources to connect route table to subnets
- **Key Learning:** Associations are explicit separate resources in Terraform, not automatic

### 5. Defining Security Group Rules in Terraform
- Used `resource "aws_security_group"` with nested `ingress` and `egress` blocks
- Each rule defined with `from_port`, `to_port`, `protocol`, `cidr_blocks`
- Security group attached to VPC using `vpc_id` parameter
- **Key Learning:** How to define firewall rules declaratively in code

### 6. Launching EC2 in Custom VPC with Terraform
- Used `resource "aws_instance"` with VPC-specific parameters
- Connected instance to subnet: `subnet_id = aws_subnet.public_subnet_1.id`
- Attached security group: `vpc_security_group_ids = [aws_security_group.web_sg.id]`
- Added `user_data` for bootstrap script
- **Key Learning:** How to place EC2 instances in custom networking using Terraform references

### 7. Terraform Implicit Dependencies
- Terraform automatically determines creation order from resource references
- No need to manually specify depends_on for most cases
- **Key Learning:** Using `aws_vpc.main_vpc.id` creates automatic dependency chain

---

## Core Terraform Patterns

### Pattern 1: Resource Reference
```hcl
vpc_id = aws_vpc.main_vpc.id
```
Format: `resource_type.resource_name.attribute`

### Pattern 2: VPC to IGW Attachment
```hcl
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
}
```

### Pattern 3: Route Table with Internet Route
```hcl
route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main_igw.id
}
```

### Pattern 4: Subnet in Specific Availability Zone
```hcl
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
}
```

### Pattern 5: Security Group Rules
```hcl
ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
```

---

## Commands Executed

```bash
# Setup
cd day-02-vpc-foundation
mkdir screenshots

# Terraform workflow
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
terraform destroy

# Git workflow
cd ..
git add day-02-vpc-foundation/
git status
git commit -m "Add Day 02: VPC Foundation with complete infrastructure"
git push origin main
```

---

## Screenshots Captured

### Terminal Screenshots:
1. ✅ `terraform-init.png` - Initialization success
2. ✅ `terraform-validate.png` - Configuration validated
3. ✅ `terraform-plan.png` - Plan showing 9 resources to add
4. ✅ `terraform-apply.png` - Apply complete with resources created
5. ✅ `terraform-destroy.png` - Destroy complete

### AWS Console Screenshots:
6. ✅ `aws-console-vpc.png` - VPC created with correct CIDR
7. ✅ `aws-console-subnets.png` - Both public subnets visible
8. ✅ `aws-console-igw.png` - Internet Gateway attached
9. ✅ `aws-console-route-table.png` - Route table with IGW route
10. ✅ `aws-console-security-group.png` - Security group rules
11. ✅ `aws-console-ec2.png` - EC2 instance running

---

## Mistakes and Challenges

**Challenge 1:** Understanding Terraform resource referencing syntax
- **Solution:** Learned the syntax `aws_vpc.main_vpc.id` creates implicit dependencies

**Challenge 2:** Route table associations are explicit in Terraform
- **Solution:** Realized that explicit `aws_route_table_association` resources are required

**Challenge 3:** Managing multiple related resources at once
- **Solution:** Understanding the dependency flow helped visualize how resources connect

---

## Questions for Further Learning

- What's the difference between public and private subnets in production environments?
- When would I need multiple route tables in one VPC?
- How do I properly restrict Security Group rules for production workloads?
- What are NAT Gateways and when are they needed?

---

## Important Notes

### AWS Regions and Availability Zones:
- Region: `us-east-2` (Ohio)
- AZs: `us-east-2a`, `us-east-2b`, `us-east-2c`
- Subnets exist in ONE AZ only
- VPCs span ALL AZs in a region

### Security Best Practices:
- Never use `0.0.0.0/0` for SSH in production
- Restrict to specific IP ranges or VPN connections
- Use separate security groups for different tiers (web, app, database)
- Follow principle of least privilege for all rules

### Resource Creation Order (Automatic):
1. VPC
2. Internet Gateway
3. Subnets
4. Route Table
5. Route Table Associations
6. Security Group
7. EC2 Instance

---

## Key Takeaways

- VPC provides network isolation in AWS cloud
- Every resource needs proper networking configuration
- Security groups are stateful (return traffic automatically allowed)
- Route tables determine traffic flow within and outside VPC
- Multiple subnets across AZs provide high availability
- Terraform manages dependencies automatically through resource references
- **My networking background (CCNP ENCORE) helped significantly** - I already understood VPC concepts from AWS Console work, but today I learned how to automate this infrastructure using Terraform code instead of manual configuration

---

## Next Steps

- Day 03: Explore advanced VPC concepts
- Learn about private subnets and NAT Gateways
- Study VPC peering and multi-tier architectures
- Practice creating isolated database subnets