# Day 04: Lambda + CloudWatch + Serverless - Learning Notes

## Day Information
- **Date:** October 8, 2025
- **Duration:** 2 hours
- **Topic:** AWS Lambda with Terraform - Serverless Computing
- **Resources Created:** 3 AWS resources (IAM Role, IAM Policy Attachment, Lambda Function)

---

## What I Learned Today (Terraform-Specific)

### 1. Creating Lambda Functions with Terraform
- Used `resource "aws_lambda_function"` block to define serverless functions
- Terraform parameters: `filename`, `function_name`, `role`, `handler`, `runtime`
- **Key Learning:** Lambda functions are defined in code but the actual execution logic is in separate Python files

### 2. IAM Roles for Lambda Execution
- Used `resource "aws_iam_role"` with `assume_role_policy` for Lambda service
- Attached `AWSLambdaBasicExecutionRole` policy for CloudWatch logging
- **Key Learning:** Lambda needs explicit permission to assume roles and write logs

### 3. Packaging Lambda Code with Archive Provider
- Used `data "archive_file"` block to zip Python code
- Parameters: `type = "zip"`, `source_file`, `output_path`
- **Key Learning:** Terraform automatically zips and deploys code to Lambda

### 4. Python Handler Function Structure
- Required function signature: `lambda_handler(event, context)`
- Must return proper response format with `statusCode` and `body`
- **Key Learning:** AWS Lambda expects specific function structure in Python

### 5. Environment Variables in Lambda
- Used `environment` block with `variables` in Lambda resource
- Secure way to pass configuration to Lambda functions
- **Key Learning:** Environment variables make Lambda functions configurable

### 6. CloudWatch Integration
- Lambda automatically creates CloudWatch log groups
- Python logging module writes to CloudWatch
- **Key Learning:** No additional setup needed for basic logging

---

## Core Terraform Patterns

### Pattern 1: Lambda IAM Role
```hcl
resource "aws_iam_role" "lambda_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}
```

### Pattern 2: Lambda Basic Execution Policy
```hcl
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
```

### Pattern 3: Code Packaging
```hcl
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda_function/lambda.py"
  output_path = "lambda_function_payload.zip"
}
```

### Pattern 4: Lambda Function Definition
```hcl
resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda_function_payload.zip"
  function_name    = "my_lambda_function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}
```

### Pattern 5: Python Handler Structure
```python
def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'Hello from Lambda!'})
    }
```

---

## Commands Executed

```bash
# Setup
mkdir day-04-lambda-cloudwatch-serverless
cd day-04-lambda-cloudwatch-serverless
mkdir lambda_function screenshots

# Terraform workflow
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
terraform destroy
```

---

## Screenshots Captured

### Terminal Screenshots:
- ✅ `terraform-init.png` - AWS and archive providers initialized
- ✅ `terraform-validate.png` - Configuration validated successfully
- ✅ `terraform-plan.png` - Plan showing 3 resources to create
- ✅ `terraform-apply.png` - Lambda function deployed successfully
- ✅ `terraform-destroy.png` - All resources cleaned up

### AWS Console Screenshots:
- ✅ `aws-console-lambda.png` - Lambda function visible in AWS Console
- ✅ `aws-console-lambda-test.png` - Successful test execution
- ✅ `aws-console-cloudwatch-logs.png` - Logs showing function execution

---

## Mistakes and Challenges

### Challenge 1: Understanding Lambda handler naming convention
- **Solution:** Learned that `handler = "lambda.lambda_handler"` means:
  - `lambda` = filename (without .py extension)
  - `lambda_handler` = function name in the file

### Challenge 2: IAM role trust relationship for Lambda
- **Solution:** Principal must be `"lambda.amazonaws.com"` for Lambda service to assume the role

---

## Questions for Further Learning

1. How do I add API Gateway as a trigger for Lambda functions?
2. What's the difference between Lambda environment variables and SSM Parameter Store?
3. How do I handle Lambda function versioning and aliases?
4. What are Lambda layers and when should I use them?

---

## Important Notes

### Serverless vs Traditional Architecture:
- **Traditional:** EC2 instances running 24/7 ($15-50/month)
- **Serverless:** Lambda functions ($0.20 per million requests)
- No server management with Lambda

### Lambda Execution Model:
- Functions run in isolated containers
- Cold starts occur when no containers are warm
- Maximum execution time: 15 minutes
- Pay only for compute time (100ms increments)

### Python Runtime Considerations:
- Python 3.9 used in this example
- Handler function must be in specific format
- All dependencies must be included in deployment package
- Environment variables available at runtime

---

## Key Takeaways

- Lambda eliminates server management - focus on code, not infrastructure
- Terraform automates deployment of both infrastructure and code
- IAM roles are critical for Lambda security and permissions
- CloudWatch provides automatic monitoring and logging
- Cost-effective for sporadic workloads - pay only when code runs
- Perfect for event-driven architectures - responds to triggers

### The Power of Serverless:
- Deployed production-ready application in minutes
- Zero ongoing costs when not in use
- Automatic scaling handled by AWS
- No operating system maintenance
- Built-in high availability

---

## Real-World Use Cases Demonstrated

- **API Backends** - Handle HTTP requests
- **File Processing** - React to S3 uploads
- **Scheduled Tasks** - Run on cron schedules
- **Data Transformation** - Process streaming data
- **Chatbots** - Handle user interactions

---

## Next Steps

- **Day 05:** RDS Databases + Multi-Tier Architecture
- Learn about connecting Lambda to databases
- Explore API Gateway integration
- Study advanced Lambda features (layers, VPC access, async invocation)
- Practice with real-world serverless patterns

---

**Completion Time:** This lesson took 2 hours including setup, deployment, testing, and cleanup. The serverless concept is faster to deploy than traditional infrastructure.