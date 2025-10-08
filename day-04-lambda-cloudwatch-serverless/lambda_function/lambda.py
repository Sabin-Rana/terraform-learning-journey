# lambda.py - AWS Lambda Function for Terraform Day 4
# This function demonstrates Lambda deployment via Terraform
# with proper logging and JSON response handling

import json
import logging

# Configure logging for CloudWatch
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    """
    AWS Lambda handler function
    
    Args:
        event: Event data passed to the function
        context: Runtime information provided by Lambda
    
    Returns:
        dict: Response object with status code and body
    """
    
    # Log invocation details for monitoring
    logger.info(f"Lambda function invoked with event: {json.dumps(event)}")
    
    try:
        # Process the request
        response_data = {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Hello from Lambda! Successfully deployed with Terraform!',
                'environment': 'production',
                'project': 'terraform-day4',
                'success': True
            })
        }
        
        logger.info("Lambda function executed successfully")
        return response_data
        
    except Exception as e:
        # Handle errors gracefully
        logger.error(f"Error in Lambda execution: {str(e)}")
        
        return {
            'statusCode': 500,
            'body': json.dumps({
                'error': 'Internal server error',
                'message': str(e)
            })
        }