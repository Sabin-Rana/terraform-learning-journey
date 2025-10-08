## My Mental Model: Serverless Computing
Think of **AWS Lambda** like running a food truck business:

| Real World Analogy | AWS Concept | Description |
|--------------------|-------------|--------------|
| Food Truck | **Lambda Function** | Your code execution unit |
| Chef | **Python/Node.js Code** | Your business logic |
| Recipe Book | **Handler Function** | Entry point for execution |
| Employee Badge | **IAM Role** | Security permissions and identity |
| Customer Orders | **Triggers** | Events that start your function |
| Kitchen Notebook | **CloudWatch Logs** | Records of all activities |
| Pay-per-meal | **Lambda Pricing** | Pay only when code runs |

# Terraform Lambda Structure - Mental Model

## Building Your Food Truck Business with Terraform

| Food Truck Setup | Terraform Resource | What It Creates |
|------------------|-------------------|-----------------|
| Business License | **IAM Role** | Permission to operate |
| Employee Badge | **IAM Policy Attachment** | Access to kitchen tools |
| Truck & Kitchen | **Lambda Function** | The food truck itself |
| Recipe Book | **Archive File** | Your cooking instructions |
| Menu Board | **Environment Variables** | Daily specials & options |

## How Terraform Connects Everything

**The Setup Flow:**
 IAM Role (Business License)
↓
IAM Policy (Employee Permissions)
↓
Archive File (Package Recipes)
↓
Lambda Function (Deploy Food Truck)


**Key Connections:**
- **Lambda Function** needs the **IAM Role** (truck needs license)
- **Lambda Function** uses the **Archive File** (truck needs recipes)
- **IAM Role** has **Policy Attachment** (employee needs badge access)

## Mental Checklist for Lambda Terraform

**Required Components:**
- [ ] IAM Role with Lambda trust relationship
- [ ] Basic execution policy for CloudWatch logs
- [ ] Code packaged in zip file
- [ ] Lambda function definition
- [ ] Handler specified (filename.function_name)
- [ ] Runtime environment (Python/Node.js/etc.)

**Automatic Benefits:**
- CloudWatch logs created automatically
- No servers to manage
- Auto-scaling built-in
- Pay-per-use billing

## The Big Picture

**Traditional Restaurant (EC2):**
- Rent kitchen 24/7
- Staff always on duty
- Pay regardless of customers

**Your Food Truck (Lambda):**
- Truck ready when needed
- Chef cooks only when ordered
- Pay only for meals served

**Terraform = Your Business Manager** that sets up the entire operation automatically!