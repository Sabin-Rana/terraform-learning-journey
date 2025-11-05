# AWS Infrastructure Automation with Terraform

*Professional infrastructure patterns implemented through systematic Infrastructure as Code*

**AWS Certified Solutions Architect - Associate**

---

## Background: From Console to Code

After building 8 AWS architectures through manual console deployment, I recognized the critical need for automation, reproducibility, and scalability. These hands-on implementations gave me deep understanding of AWS service interactions before automating with Terraform. This repository documents the systematic transition from click-based infrastructure management to declarative Infrastructure as Code.

**Read the complete story:** [Starting My Terraform Journey: From AWS Console to Infrastructure as Code](https://sabin-codeops.hashnode.dev/starting-my-terraform-journey-from-aws-console-to-infrastructure-as-code)

### Foundation: Console-Based AWS Projects

Before automating with Terraform, I built hands-on expertise through 8 detailed implementations:

**Featured Architectures:**
- [3-Tier Web Architecture](https://github.com/Sabin-Rana/aws-3tier-architecture) - VPC, ALB, EC2 Auto Scaling, RDS Multi-AZ (115+ documented steps)
- [Serverless Student Management](https://github.com/Sabin-Rana/aws-serverless-architecture-showcase) - Lambda, API Gateway, DynamoDB with CRUD operations
- [Secure VPC Network Isolation](https://github.com/Sabin-Rana/aws-vpc-network-isolation) - Public/private subnets with high availability

**Security & Access Management:**
- [Secure EC2 Access with SSM](https://github.com/Sabin-Rana/aws-secure-ec2-access-with-ssm) - Zero-trust access without SSH or open ports
- [IAM Role-Based Access Control](https://github.com/Sabin-Rana/aws-iam-role-based-access) - User groups, policies, MFA, least privilege

**Automation & Deployment:**
- [Bulk User Management](https://github.com/Sabin-Rana/aws-bulk-user-management) - Python automation with AWS CLI
- [S3 Static Portfolio Site](https://github.com/Sabin-Rana/aws-s3-static-portfolio-site) - Secure cloud hosting
- [AWS CLI S3 Setup](https://github.com/Sabin-Rana/aws-cli-s3-setup) - Configuration and operations guide

This foundation provided deep understanding of AWS service dependencies, security patterns, and architectural trade-offs—essential knowledge for effective infrastructure automation.

---

## Project Scope

### Phase 1: Foundation (Days 1-4)
**Core Infrastructure & Compute**
- EC2 instances with security configurations and AMI selection
- VPC networking with subnets, route tables, and internet gateways
- S3 storage with IAM security and access management
- Lambda serverless functions with CloudWatch monitoring

### Phase 2: Databases & Architecture (Days 5-6)
**Multi-Tier Systems & Global Delivery**
- RDS databases with Multi-AZ deployment and security groups
- Complete 3-tier web application architecture
- Route53 DNS management and domain configuration
- CloudFront CDN with SSL certificates (ACM)

### Phase 3: Advanced Concepts (Days 7-8)
**Professional Practices & Collaboration**
- Reusable Terraform modules and component design
- Remote state management with S3 backend and DynamoDB locking
- GitHub Actions CI/CD integration patterns
- Workspace management for multi-environment deployments

### Phase 4: Professional Standards (Days 9-10)
**Security, Optimization & Advanced Patterns**
- Security scanning and AWS security best practices
- Automated cost protection and budget management
- Advanced Terraform patterns: count vs for_each, dynamic blocks
- Complex module architectures and variable validation

---

## Key Achievements

### Efficiency & Automation
- **Deployment Time Reduction:** Manual console deployment (45 min) → Terraform automation (3 min) - 93% efficiency gain
- **Reproducibility:** 100% consistent infrastructure across environments
- **Zero-Downtime Capability:** Automated deployment with minimal disruption

### Safety & Cost Management
- Automated cost protection scripts with emergency termination
- Comprehensive security scanning and compliance automation
- State management with locking to prevent conflicts
- Detailed troubleshooting documentation for common issues

### Technical Implementation
- **10+ AWS Services:** Orchestrated end-to-end infrastructure
- **Professional-Grade Modules:** Reusable, tested components

---

## Technologies & Skills

### AWS Services
EC2, VPC, S3, Lambda, RDS, Route53, CloudFront, IAM, CloudWatch, ACM, Systems Manager

### Terraform Concepts
- Resource management and lifecycle
- Variables, outputs, and data sources
- Modules and composition patterns
- Remote state with S3 + DynamoDB
- Workspaces for environment management
- Advanced iteration (count, for_each)
- Dynamic blocks and meta-arguments
- Variable validation and type constraints

### DevOps Practices
- Infrastructure as Code principles
- Version control for infrastructure
- Automated cost optimization
- Security-first design patterns
- CI/CD pipeline integration
- Team collaboration workflows

---

## Repository Structure

Each day's implementation includes comprehensive documentation:

```
terraform-learning-journey/
├── automation-scripts/              # Cost protection automation suite
├── day-01-terraform-basics-ec2/
├── day-02-vpc-foundation/
├── day-03-s3-iam-security/
├── day-04-lambda-cloudwatch-serverless/
├── day-05-rds-multi-tier/
├── day-06-route53-cloudfront/
├── day-07-modules-state-management/
├── day-08-ci-cd-team-collaboration/
├── day-09-security-cost-optimization/
└── day-10-advanced-patterns/
```

**Each Day Contains:**
- **Terraform configurations** - Complete .tf files for infrastructure
- **notes.md** - Implementation details with troubleshooting steps and screenshots
- **learning-notes.md** - Technical concepts, mental models, and best practices
- **screenshots/** - Visual documentation of execution and results

---

## Cost Protection & Security

### Automated Safeguards
- Quick resource verification scripts
- Detailed AWS cost analysis tools
- Emergency resource termination procedures
- Budget safety measures and alerts

### Security Implementation
- IAM best practices with least privilege
- Security group hardening and network isolation
- Encryption at rest and in transit
- Automated security scanning
- Audit logging and compliance tracking

---

## Getting Started

### Prerequisites
```bash
- AWS Account with appropriate permissions
- Terraform >= 1.0 installed
- AWS CLI configured with credentials
- Basic understanding of cloud concepts
```

### Basic Workflow
```bash
# Navigate to any day's folder
cd day-XX-folder/

# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply infrastructure
terraform apply

# Cleanup resources (important for cost management)
terraform destroy
```

### Cost Management Note
Always run `terraform destroy` after testing to avoid unexpected AWS charges. Use the provided automation scripts for quick resource verification.

---

## What's Next

Building on this foundation, my next phase focuses on:

- **Enterprise CI/CD Pipelines** - GitHub Actions integration with automated testing
- **Multi-Region Deployments** - Advanced networking and failover strategies
- **Container Orchestration** - ECS/EKS with Terraform automation
- **Full Observability Stack** - Monitoring, logging, and alerting infrastructure
- **Advanced Security Patterns** - Secrets management, compliance automation

---

## Certifications

**AWS Certified Solutions Architect - Associate**

---

## About This Project

This repository represents a structured, hands-on approach to mastering Infrastructure as Code. Each phase builds upon previous concepts while introducing production-ready patterns and practices used in enterprise environments.

The progression from manual console work to automated IaC demonstrates not just technical capability, but strategic thinking about infrastructure management, team collaboration, and operational excellence.

**Context & Motivation:** [Read the full blog post](https://sabin-codeops.hashnode.dev/starting-my-terraform-journey-from-aws-console-to-infrastructure-as-code)

**Previous Console Work:** See the 8 foundational AWS projects linked in the Background section above

---

## Connect

- **Blog:** [sabin-codeops.hashnode.dev](https://sabin-codeops.hashnode.dev)
- **GitHub:** [@Sabin-Rana](https://github.com/Sabin-Rana)

---

*Star this repository if you're learning Terraform or transitioning to Infrastructure as Code!*

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/Sabin-Rana/terraform-learning-journey/blob/main/LICENSE) file for details.

You are free to use this code for learning, personal projects, or commercial applications with attribution.
