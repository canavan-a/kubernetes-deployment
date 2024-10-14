# get kubernetes runtime: (k3s)
# k3s comes with kubectl baked in
curl -sfL https://get.k3s.io | sh -
sudo systemctl status k3s
sudo k3s kubectl get nodes

# add permission for kubectl 
sudo ln -s /usr/local/bin/k3s /usr/local/bin/kubectl

kubectl version --client

kubectl version --client --output=yaml

# get nginx ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml