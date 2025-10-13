#!/bin/bash
# Quick Cost Check - Run after every Terraform session

echo "QUICK COST SAFETY CHECK"
echo "======================="

# Check each service and count resources
ec2_count=$(aws ec2 describe-instances --query 'Reservations[].Instances[?State.Name==`running`].InstanceId' --output text 2>/dev/null | wc -w)
rds_count=$(aws rds describe-db-instances --query 'DBInstances[?DBInstanceStatus==`available`].DBInstanceIdentifier' --output text 2>/dev/null | wc -w)
s3_count=$(aws s3 ls 2>/dev/null | wc -l)
lambda_count=$(aws lambda list-functions --query 'length(Functions)' --output text 2>/dev/null)

echo "EC2 Instances: $ec2_count"
echo "RDS Databases: $rds_count" 
echo "S3 Buckets: $s3_count"
echo "Lambda Functions: $lambda_count"

total=$((ec2_count + rds_count + s3_count + lambda_count))

if [ $total -eq 0 ]; then
    echo "STATUS: ALL CLEAN - No costly resources running"
else
    echo "STATUS: WARNING - $total resources found that may incur costs"
    echo "ACTION: Run ./cost-checker.sh for detailed view"
fi