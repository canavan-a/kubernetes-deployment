# kubernetes-deployment

k8s deployment to run all my personal projects on ec2 behind nginx

view logs for a deployment:

`kubectl logs -f -l app={app name} -n {namespace-name}`

TODO: check if watchtower works

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
