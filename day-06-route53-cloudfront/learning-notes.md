# Day 06: Route53 DNS + CloudFront CDN + ACM SSL

> Learning global web infrastructure, DNS management, content delivery networks, and free SSL certificates with cost-effective strategies.

---

## My Mental Model: Global Web Infrastructure

Think of **AWS Web Services** like running a global restaurant chain:

| Real World Analogy | AWS Concept | Description |
|--------------------|-------------|--------------|
| Restaurant Chain HQ | **Route53** | Manages all location addresses and directions |
| Global Delivery Fleet | **CloudFront** | Worldwide content delivery network |
| Food Safety Certificate | **ACM SSL** | Security and trust verification for customers |
| Unique Restaurant Names | **Random Provider** | Generates unique domain names |
| Customer Directions | **Outputs** | How people find your services |
| Business Locations | **AWS Regions** | Where your services operate |

---

## Terraform Web Infrastructure - Mental Model

### Building Your Global Restaurant Chain with Terraform

| Restaurant Chain Setup | Terraform Resource | What It Creates |
|-----------------------|-------------------|-----------------|
| Business Expansion Plan | **Variables** | Your global strategy and rules |
| Headquarters Address | **Route53 Zone** | Central DNS management |
| Delivery Fleet | **CloudFront Distribution** | Global content delivery |
| Safety Certificates | **ACM Certificate** | Free SSL security |
| Unique Brand Names | **Random Pet** | Generates unique identifiers |
| Customer Navigation | **Outputs** | How to access your services |

### How Terraform Connects Everything

**The Setup Flow:**

Variables (Global Business Plan)
↓
Random Names (Unique Branding)
↓
Route53 (Headquarters Address)
↓
CloudFront (Global Delivery Fleet)
↓
ACM (Safety Certificates)
↓
Outputs (Customer Directions)

**Key Connections:**
- **Route53** provides DNS for the domain
- **CloudFront** uses the domain for global delivery
- **ACM** provides SSL security for the domain
- **Random Provider** ensures unique naming
- **Outputs** give access information

---

## Mental Checklist for Web Infrastructure Terraform

### Required Components:
- [ ] Random provider for unique domain names
- [ ] Route53 hosted zone for DNS management
- [ ] CloudFront distribution for global delivery
- [ ] ACM certificate for SSL security
- [ ] Variables for configuration
- [ ] Outputs for access information