# get kubernetes runtime: (k3s)
# k3s comes with kubectl baked in
curl -sfL https://get.k3s.io | sh -
sudo systemctl status k3s
sudo k3s kubectl get nodes

sudo kubectl version --client

sudo kubectl version --client --output=yaml

# get nginx ingress
sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

