#!/bin/bash
# AWS Cost Checker Script
# Comprehensive resource checking to prevent surprise bills

echo "AWS COST AND RESOURCE CHECKER"
echo "=============================="
echo "Checking for active resources..."
echo ""

# Function to check and display resources
check_resource() {
    local service=$1
    local command=$2
    local query=$3
    local description=$4
    
    echo "Checking: $description"
    eval "aws $command --query '$query' --output table" 2>/dev/null || echo "  No resources or access denied"
    echo ""
}

# HIGH COST SERVICES - Check First
echo "HIGH COST SERVICES"
echo "=================="
check_resource "EC2" "ec2 describe-instances" 'Reservations[].Instances[?State.Name==`running`].{Instance:InstanceId, Type:InstanceType, State:State.Name}' "Running EC2 Instances"
check_resource "RDS" "rds describe-db-instances" 'DBInstances[?DBInstanceStatus==`available`].{DB:DBInstanceIdentifier, Engine:Engine, Status:DBInstanceStatus}' "Running RDS Databases"
check_resource "EKS" "eks list-clusters" 'clusters' "EKS Clusters"

# MODERATE COST SERVICES
echo "MODERATE COST SERVICES"
echo "======================"
check_resource "ELB" "elbv2 describe-load-balancers" 'LoadBalancers[].{LB:LoadBalancerName, Type:Type, State:State.Code}' "Load Balancers"
check_resource "NAT" "ec2 describe-nat-gateways" 'NatGateways[?State==`available`].{NatGatewayId:NatGatewayId, State:State}' "NAT Gateways"
check_resource "EBS" "ec2 describe-volumes" 'Volumes[?State==`in-use`].{VolumeId:VolumeId, Size:Size, State:State}' "EBS Volumes in-use"

# LOW COST SERVICES
echo "LOW COST SERVICES"
echo "================="
echo "Checking: S3 Buckets"
aws s3 ls 2>/dev/null | head -10
echo "(Showing first 10 buckets)"
echo ""

check_resource "Lambda" "lambda list-functions" 'Functions[].{Function:FunctionName, Runtime:Runtime}' "Lambda Functions"
check_resource "DynamoDB" "dynamodb list-tables" 'TableNames' "DynamoDB Tables"
check_resource "API Gateway" "apigateway get-rest-apis" 'items[].{Id:id, Name:name}' "API Gateway APIs"

# SUMMARY
echo "QUICK SUMMARY"
echo "============="
echo "Running EC2 Instances: $(aws ec2 describe-instances --query 'Reservations[].Instances[?State.Name==`running`].InstanceId' --output text 2>/dev/null | wc -w)"
echo "S3 Buckets: $(aws s3 ls 2>/dev/null | wc -l)"
echo "Lambda Functions: $(aws lambda list-functions --query 'length(Functions)' --output text 2>/dev/null)"
echo "RDS Databases: $(aws rds describe-db-instances --query 'length(DBInstances[?DBInstanceStatus==`available`])' --output text 2>/dev/null)"

echo ""
echo "COST CHECK COMPLETE"
echo "TIP: Run this after every Terraform session"