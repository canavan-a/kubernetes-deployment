#!/bin/bash

# Log the current date for debugging
echo "Script started at $(date)" >> /var/log/ecr-cron.log

# Define AWS Region and Account ID
AWS_REGION=us-east-2
AWS_ACCOUNT_ID=766216391680

# Delete the existing secret (ignore if not found)
sudo kubectl delete secret ecr-creds --namespace acanavan-namespace --ignore-not-found >> /var/log/ecr-cron.log 2>&1

# Check if the secret deletion was successful
if [[ $? -eq 0 ]]; then
    echo "Existing secret deleted successfully at $(date)" >> /var/log/ecr-cron.log
else
    echo "Failed to delete existing secret at $(date)" >> /var/log/ecr-cron.log
fi

# Generate new ECR credentials
SECRET_PASSWORD=$(aws ecr get-login-password --region $AWS_REGION)

# Check if the password retrieval was successful
if [[ $? -ne 0 ]]; then
    echo "Failed to get ECR login password at $(date)" >> /var/log/ecr-cron.log
    exit 1
fi

# Create a new secret with the ECR credentials
sudo kubectl create secret docker-registry ecr-creds \
    --docker-server="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com" \
    --docker-username=AWS \
    --docker-password="${SECRET_PASSWORD}" \
    --docker-email=aidan.canavan3@gmail.com \
    --namespace acanavan-namespace >> /var/log/ecr-cron.log 2>&1

# Check if the secret creation was successful
if [[ $? -eq 0 ]]; then
    echo "Secret created successfully at $(date)" >> /var/log/ecr-cron.log
else
    echo "Failed to create secret at $(date)" >> /var/log/ecr-cron.log
fi

echo "Script finished at $(date)" >> /var/log/ecr-cron.log
