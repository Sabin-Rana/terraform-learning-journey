#!/bin/bash
# Day 9: Cost Estimation Script
# Manual cost analysis

echo "COST ESTIMATION REPORT"
echo "======================"

echo "CURRENT INFRASTRUCTURE COSTS:"
echo "1. S3 BUCKET (secure-data-*):"
echo "   - Storage: ~$0.023 per GB/month"
echo "   - Requests: Minimal cost"
echo "   - Data Transfer: Minimal cost"
echo ""

echo "2. LAMBDA FUNCTION (security-scanner-*):"
echo "   - Requests: $0.20 per 1M requests"
echo "   - Compute: $0.0000166667 per GB-second"
echo "   - Free Tier: 1M requests/month free"
echo ""

echo "3. ESTIMATED MONTHLY COST:"
echo "   - Development: ~$0.50 - $1.00"
echo "   - Production: ~$5.00 - $10.00"
echo ""

echo "COST OPTIMIZATION RECOMMENDATIONS:"
echo "   - Use S3 Intelligent-Tiering"
echo "   - Set Lambda memory/timeout limits"
echo "   - Implement auto-scaling policies"
echo "   - Use AWS Budgets for alerts"
echo ""

echo "COST ESTIMATION COMPLETE"