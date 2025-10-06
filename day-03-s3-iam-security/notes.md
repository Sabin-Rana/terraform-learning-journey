# Day 03: S3 Storage + IAM Security - Learning Notes

## Day Information
- **Date:** October 6, 2025
- **Duration:** 3 hours 35 minutes
- **Topic:** S3 Storage + IAM Security - Static Websites, IAM Roles, JSON Encoding
- **Resources Created:** 15 AWS resources (S3 bucket, IAM role/policy, EC2 instance, etc.)

---

## What I Learned Today (Terraform-Specific)

### 1. Using Random Provider for Unique Names
- Used `random_pet` provider to generate unique bucket names
- **Key Learning:** S3 bucket names must be globally unique across ALL AWS accounts
- **Pattern:** `"${random_pet.bucket_name.id}-static-website"`

### 2. S3 Static Website Configuration
- Created S3 bucket with `aws_s3_bucket` resource
- Configured website hosting with `aws_s3_bucket_website_configuration`
- **Key Learning:** S3 can directly host static websites without web servers
- **Pattern:** Separate resources for bucket, website config, and policies

### 3. S3 Bucket Policies with JSON Encoding
- Used `jsonencode()` function to create bucket policies
- **Key Learning:** Terraform can generate JSON policies dynamically
- **Pattern:** `policy = jsonencode({ Version = "2012-10-17", Statement = [...] })`

### 4. IAM Role and Policy Creation
- Created IAM role with `aws_iam_role`
- Defined policy with `aws_iam_policy` using `jsonencode()`
- **Key Learning:** IAM policies are defined as JSON documents in Terraform
- **Pattern:** Assume role policy for EC2 service principal

### 5. IAM Instance Profiles
- Created `aws_iam_instance_profile` to attach IAM role to EC2
- **Key Learning:** EC2 instances use instance profiles, not direct role attachment
- **Pattern:** Instance profile connects role to EC2 instance

### 6. Uploading Files to S3
- Used `aws_s3_object` to upload HTML files
- **Key Learning:** Can create file content directly in Terraform with HEREDOC syntax
- **Pattern:** `content = <<EOF ... EOF` for inline file creation

### 7. Variables and Outputs in Practice
- Used `variables.tf` for customizable values
- Used `outputs.tf` to display useful information after creation
- **Key Learning:** Variables make code reusable, outputs provide actionable information

---

## Core Terraform Patterns

### Pattern 1: Random Provider for Unique Names
```hcl
resource "random_pet" "bucket_name" {
  length    = 2
  separator = "-"
}

bucket = "${random_pet.bucket_name.id}-static-website"
```

### Pattern 2: S3 Static Website Setup
```hcl
resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  index_document { suffix = "index.html" }
  error_document { key = "error.html" }
}
```

### Pattern 3: JSON-encoded IAM Policy
```hcl
policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.static_website.arn}/*"
    },
  ]
})
```

### Pattern 4: IAM Role for EC2
```hcl
resource "aws_iam_role" "s3_read_only_role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}
```

### Pattern 5: File Upload to S3
```hcl
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  content      = <<EOF
<html>...content...</html>
EOF
  content_type = "text/html"
}
```

---

## Detailed Troubleshooting & Challenges

### Challenge 1: Duplicate Resource Errors

**Error Message:**
```
Error: Duplicate resource "aws_iam_role_policy_attachment" configuration
A aws_iam_role_policy_attachment resource named "s3_read_only_attach" was already declared
Resource names must be unique per type in each module.
```

**What Happened:**
- Accidentally pasted the same resource blocks multiple times in main.tf
- Had duplicate sections for IAM role policy attachment, instance profile, security group, and EC2 instance

**Root Cause:**
- During step-by-step building, I added resources multiple times without realizing they were already defined
- Terraform detected the same resource names declared twice

**Solution:**
- Opened main.tf and carefully reviewed all resource blocks
- Removed duplicate resource definitions
- Kept only one instance of each resource type with unique names
- Learned that Terraform requires unique resource names within the same module

---

### Challenge 2: Outputs Referencing Non-Existent Resources

**Error Message:**
```
Error: Reference to undeclared resource
on outputs.tf line 15, in output "iam_role_name":
value = aws_iam_role.s3_read_only_role.name
A managed resource "aws_iam_role" "s3_read_only_role" has not been declared in the root module.
```

**What Happened:**
- Created outputs.tf that referenced resources before they were defined in main.tf
- Outputs were looking for IAM role and EC2 instance that didn't exist yet

**Root Cause:**
- Built files in wrong order - outputs before main resources
- Terraform validates all files together, so outputs couldn't find their referenced resources

**Solution:**
- Continued building main.tf until all referenced resources were defined
- Learned that Terraform reads all .tf files together, so dependencies must exist
- Understood that this is normal during incremental development

---

### Challenge 3: Understanding IAM Instance Profiles

**Confusion Point:**
- Initially didn't understand why we needed both IAM roles AND instance profiles
- Was confused about the connection between EC2 and IAM permissions

**Learning Process:**
- Researched AWS IAM documentation
- Learned that EC2 instances cannot directly assume IAM roles
- Instance profiles act as the "bridge" between EC2 and IAM roles
- The flow: IAM Role → IAM Policy → Instance Profile → EC2 Instance

**Solution:**
- Created proper instance profile resource
- Attached instance profile to EC2 instance using iam_instance_profile attribute
- Understood the complete permission chain

---

### Challenge 4: JSON Encoding Syntax

**Initial Difficulty:**
- Complex nested JSON structure for IAM policies
- Confusion about proper Terraform HCL to JSON conversion

**Learning Breakthrough:**
- Used jsonencode() function to automatically handle JSON formatting
- Learned that Terraform converts HCL maps/lists to proper JSON
- No need to manually write JSON strings

**Solution Pattern:**
```hcl
policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Effect = "Allow"
      Action = "s3:GetObject"
      Resource = "${aws_s3_bucket.static_website.arn}/*"
    }
  ]
})
```

---

# Terraform workflow with troubleshooting
terraform init
terraform validate  # FAILED - duplicate resources
terraform validate  # FAILED - missing resources
terraform fmt
terraform validate  # SUCCESS - after cleanup
terraform plan
terraform apply
terraform output
terraform destroy


---

## Screenshots Captured

### Terminal Screenshots:
- terraform-init.png - Initialization success
- terraform-validate-error.png - Validation errors (learning process)
- terraform-validate-progress.png - Progress fixing errors
- terraform-validate-clean.png - Clean validation
- terraform-plan.png - Plan showing 15 resources
- terraform-apply.png - Apply complete with outputs
- terraform-output.png - Output values
- terraform-destroy.png - Destroy complete

### AWS Console Screenshots:
- aws-console-s3.png - S3 bucket list
- aws-console-s3-objects.png - Objects in bucket
- aws-console-s3-website.png - Static website configuration
- aws-console-ec2.png - EC2 instance with IAM role
- aws-console-iam-role.png - IAM role and policies

---

## Key Troubleshooting Lessons

### 1. Incremental Development is Normal
- It's okay to have errors during step-by-step building
- Terraform validation helps catch issues early
- Each error is a learning opportunity

### 2. Resource Dependencies Matter
- Outputs depend on resources existing first
- Terraform validates all files together
- Build resources before referencing them

### 3. Clean Code Practices
- Avoid duplicate resource definitions
- Use consistent naming conventions
- Regularly run terraform validate to catch issues

### 4. AWS Service Relationships
- EC2 → Instance Profile → IAM Role → IAM Policy
- S3 Bucket → Bucket Policy → Public Access
- Understanding service relationships prevents configuration errors

---

## Questions for Further Learning

1. What's the difference between S3 bucket policies and IAM policies?
2. When should I use S3 static hosting vs EC2 web servers?
3. How do I secure S3 buckets in production environments?
4. What are the best practices for IAM role design?

---

## Important Architecture Insights

### S3 Static Website Features:
- Direct URL access without web servers: http://bucket-name.s3-website-region.amazonaws.com
- Cost-effective for static content (HTML, CSS, JS, images)
- Automatic scaling - no servers to manage
- Limited to static files only

### IAM Security Flow:
- IAM Role - Identity with permissions
- IAM Policy - JSON document defining permissions
- Instance Profile - Container for the role
- EC2 Instance - Assumes the role via instance profile

### Terraform File Structure:
- main.tf - Resource definitions and dependencies
- variables.tf - Customizable parameters for reusability
- outputs.tf - Useful information display after creation

---

## Key Takeaways

### Technical Skills Gained:
- S3 static website hosting configuration
- IAM role and policy creation with JSON encoding
- Random provider for unique resource naming
- Terraform variables and outputs implementation
- EC2 instance profiles for secure S3 access

### Problem-Solving Skills:
- Debugging duplicate resource errors
- Understanding resource dependency chains
- Incremental development with validation
- AWS service relationship mapping

### Real-World Application:
- **Scenario:** EC2 instance manages S3 content while S3 serves it directly to users
- **Use Case:** Static company website with backend management capabilities
- **Architecture:** Separation of concerns - storage vs computation

---

## Next Steps

### Day 04: Lambda + CloudWatch + Serverless
- Learn about serverless architectures and event-driven patterns
- Explore AWS Lambda functions and triggers
- Study monitoring and logging with CloudWatch
- Build complete serverless applications

---

## Final Reflection

Today's session was challenging but incredibly valuable. The troubleshooting process taught me more than just following perfect code. Understanding WHY errors happen and HOW to fix them is where real learning occurs. The duplicate resource issue specifically taught me to be more careful with incremental development, while the output dependencies helped me understand Terraform's file processing order.

The combination of S3 for storage and IAM for security creates powerful, scalable architectures. Moving variables and outputs from theoretical concepts to practical implementation solidified my understanding of professional Terraform workflows.

Ready for Day 04!