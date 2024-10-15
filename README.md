# kubernetes-deployment

k8s deployment to run all my personal projects on ec2 behind nginx

view logs for a deployment:

`kubectl logs -f -l app={app name} -n {namespace-name}`

TODO: check if watchtower works

## connect to ec2 with ssh

go to secure .pem file location: `C:\Users\Aidan\.ssh`

use command to ssh:
`ssh -i acanavan-keypair.pem ec2-user@ec2-18-224-82-237.us-east-2.compute.amazonaws.com`
