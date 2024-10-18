# kubernetes-deployment

k8s deployment to run all my personal projects on ec2 behind nginx

view logs for a deployment:

`kubectl logs -f -l app={app name} -n {namespace-name}`

## connect to ec2 with ssh

go to secure .pem file location: `C:\Users\Aidan\.ssh`

use command to ssh:
`ssh -i acanavan-keypair.pem ec2-user@ec2-18-222-152-137.us-east-2.compute.amazonaws.com`

## making a cert

1. install the certbot/certbot docker image

2. run the command and follow steps

   `sudo docker run -it --rm \
-v /etc/letsencrypt:/etc/letsencrypt \
-v /var/lib/letsencrypt:/var/lib/letsencrypt \
certbot/certbot certonly --manual --preferred-challenges=dns \
-d "*.acanavan.com"`

3. for wildcard certs, add the TXT record in DNS settings:

   `_acme-challenge.{your domain}.com`

4. generate secret based on the cert, point to this secret in ingress controller

   for example:

   `kubectl create secret tls acanavan-manual-letsencrypt-tls \
--cert=/etc/letsencrypt/live/acanavan.com/fullchain.pem \
--key=/etc/letsencrypt/live/acanavan.com/privkey.pem \
-n acanavan-namespace`

## credentialing ECR

1. add a IAM role that has AmazonEC2ContainerRegistryPullOnly and cli access
2. use aws configure to sign into the role in EC2
3. allow docker to have access to aws and low level control

   `> sudo usermod -aG docker ec2-user`

   `> newgrp docker`

4. run a `docker pull` on your favorite repo
5. create a long term secret for ECR

   `ECR_PASSWORD=$(aws ecr get-login-password --region us-east-2)`

   `sudo kubectl create secret docker-registry ecr-creds \
--docker-server=766216391680.dkr.ecr.us-east-2.amazonaws.com \
--docker-username=AWS \
--docker-password="$ECR_PASSWORD" \
-n acanavan-namespace`

6. reference this secret in your deployment.yaml file
