# Delete the existing secret
sudo kubectl delete secret ecr-creds --namespace acanavan-namespace --ignore-not-found

# Generate new ECR credentials
AWS_REGION=us-east-2
AWS_ACCOUNT_ID=766216391680

SECRET_JSON=$(aws ecr get-login-password --region $AWS_REGION | \
jq -R --arg id "${AWS_ACCOUNT_ID}" --arg region "${AWS_REGION}" '{
    "auths": {
    ($id + ".dkr.ecr." + $region + ".amazonaws.com"): {
        "auth": .
    }
    }
}')

# Create a new secret with the ECR credentials
sudo kubectl create secret docker-registry ecr-creds \
--docker-server="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com" \
--docker-username=AWS \
--docker-password="$(aws ecr get-login-password --region $AWS_REGION)" \
--docker-email=aidan.canavan3@gmail.com \
--namespace acanavan-namespace