#!/bin/bash
# Safety Destroy Script - Prevents cost overruns

echo "SAFETY DESTROY ACTIVATED"
echo "========================"

# Find all Terraform directories and destroy resources
find . -name "*.tf" -exec dirname {} \; | sort -u | while read dir; do
  if [ -f "$dir/terraform.tfstate" ]; then
    echo "Destroying resources in: $dir"
    cd "$dir" 
    terraform destroy -auto-approve
    cd - > /dev/null
  fi
done

echo "DESTROY COMPLETE"
echo "All resources have been destroyed"
echo "Cost bleeding prevented"