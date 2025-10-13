#!/bin/bash
# Day 9: Secure Deployment Script
# Automated deployment with security and cost checks

echo "DAY 9: SECURE DEPLOYMENT SCRIPT"
echo "=========================================="

# Step 1: Initialize and Validate
echo "Step 1: Initializing Terraform..."
terraform init

echo "Step 2: Validating configuration..."
terraform validate

# Step 2: Security Scan
echo "Step 3: Running security scan..."
./scripts/security-scan.sh

# Step 3: Cost Estimate
echo "Step 4: Running cost estimation..."
./scripts/cost-estimate.sh

# Step 4: Plan and Deploy
echo "Step 5: Planning secure deployment..."
terraform plan

echo "Step 6: Ready to deploy secure infrastructure? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
    echo "Step 7: Deploying secure infrastructure..."
    terraform apply -auto-approve
    echo "Secure deployment complete!"
else
    echo "Deployment cancelled by user."
fi

echo "=========================================="
echo "Secure deployment script finished!"