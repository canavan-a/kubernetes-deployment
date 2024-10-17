#!/bin/bash

# Step 1: Generate a self-signed TLS certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout my-cert.key \
    -out my-cert.crt \
    -subj "/CN=*.acanavan.com/O=My Company/C=US"

# Step 2: Create a Kubernetes secret with the certificate and key
kubectl create secret tls acanavan-manual-tls \
    --cert=my-cert.crt \
    --key=my-cert.key \
    --namespace acanavan-namespace

kubectl create secret tls acanavan-manual-letsencrypt-tls \
    --cert=/etc/letsencrypt/live/acanavan.com/fullchain.pem \
    --key=/etc/letsencrypt/live/acanavan.com/privkey.pem

# Optional: Clean up the generated files if you don't need them locally
rm my-cert.key my-cert.crt
