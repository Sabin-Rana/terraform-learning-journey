#!/bin/bash
# Day 9: Secure Destruction Script
# Safe cleanup of all resources

echo "SECURE DESTRUCTION SCRIPT"
echo "=========================="

echo "Step 1: Planning destruction..."
terraform plan -destroy

echo "Step 2: Ready to destroy all resources? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
    echo "Step 3: Destroying infrastructure..."
    terraform destroy -auto-approve
    echo "Destruction complete - all resources removed!"
    
    # Clean up local files
    echo "Step 4: Cleaning up local files..."
    rm -f lambda_function_payload.zip
    rm -rf lambda/
    echo "Local cleanup complete!"
else
    echo "Destruction cancelled by user."
fi

echo "=========================="
echo "Secure destruction script finished!"