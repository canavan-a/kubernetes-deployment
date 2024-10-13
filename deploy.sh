#!/bin/bash

# get nginx ingress
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

# namespace
kubectl apply -f k8s/namespace.yaml

# applications
kubectl apply -f k8s/vitesweeper.yaml

# watchtower
kubectl apply -f k8s/watchtower.yaml

# nginx
kubectl apply -f k8s/ingress.yaml

echo "Kubernetes resources applied successfully."