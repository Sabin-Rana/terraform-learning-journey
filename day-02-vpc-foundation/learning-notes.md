# VPC Quick Reference

## My Mental Model: Building a Private Network
Think of **VPC** like building a private office building:

| Real World Analogy | AWS Concept | Description |
|--------------------|-------------|--------------|
| Land | **VPC** | Your private cloud space |
| Floor Plans | **Subnets** | Logical divisions (departments) |
| Main Entrance | **Internet Gateway (IGW)** | Entry to the internet |
| Security Desk | **Security Groups** | Instance-level firewall |
| Building Rules | **Route Tables** | Direct network traffic |
| Network Doors | **Route Table Associations** | Connect routing rules to subnets |

---

## Core Components

### **VPC**
- Your **private network space**
- Defined by **IP range (CIDR block)**
- **Region-specific**
- **Isolated** from other VPCs

### **Subnet**
- Network **segments** within the VPC  
- **Public Subnet** → Has internet access  
- **Private Subnet** → No direct internet access  
- **AZ-specific** (spread across multiple Availability Zones)

### **Internet Gateway (IGW)**
- **Single gateway per VPC**
- Provides **internet communication**
- Must be **attached** to the VPC

### **Route Table**
- Defines **traffic directions**
- Default local route for internal VPC traffic
- Internet route example: `0.0.0.0/0 → IGW`

---

## Terraform Pattern Structure

### **Step 1: Define the VPC (Land)**
- Create main VPC resource with **CIDR block**
- Configure:
  - `enable_dns_support = true`
  - `enable_dns_hostnames = true`

### **Step 2: Create Internet Gateway (Main Entrance)**
- Create and **attach** IGW to VPC  
- Enables external internet connectivity

### **Step 3: Create Subnets (Floor Plans)**
- Define **public subnets** in different AZs  
- Define **private subnets** in different AZs  
- Set `map_public_ip_on_launch = true` for public subnets

### **Step 4: Create Route Tables (Building Rules)**
- **Public Route Table** → Route to Internet Gateway  
- **Private Route Table** → Local routes only

### **Step 5: Associate Route Tables (Install Rules)**
- Link **public subnets** → Public route table  
- Link **private subnets** → Private route table

### **Step 6: Create Security Groups (Security Desk)**
- Define **Ingress** (inbound) and **Egress** (outbound) rules  
- Attach to instances within the VPC

---

## CIDR Planning

| CIDR | Approx. IPs | Typical Use |
|------|--------------|-------------|
| `/16` | 65,536 | VPC size |
| `/24` | 256 | Subnet size |
| `/28` | 16 | Small subnet |

---

## Essential Terraform Attributes

| Resource | Key Attributes |
|-----------|----------------|
| **VPC** | `cidr_block`, `enable_dns_support`, `enable_dns_hostnames` |
| **Subnet** | `vpc_id`, `cidr_block`, `availability_zone`, `map_public_ip_on_launch` |
| **Route Table** | `vpc_id`, `route` (configurations) |
| **Security Group** | `vpc_id`, `ingress`, `egress` rules |

---

## Mental Checklist

- [x] VPC created with CIDR block  
- [x] Internet Gateway attached  
- [x] Subnets spread across multiple AZs  
- [x] Route Tables properly configured  
- [x] Route Table Associations made  
- [x] Security Groups attached for protection  

---

📘 **Tip:**  
Keep this reference handy when designing AWS networks or building Terraform modules — it’s your quick map from **concept → configuration**.
