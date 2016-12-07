#!/bin/bash
openssl req -x509 -nodes -day 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=foo.bar.com"

echo "
apiVersion: v1
kind: Secret
metadata:
  name: foo-secret
data:
  tls.crt: `base64 -w 10000 tls.crt`
  tls.key: `base64 -w 10000 tls.key`
" > secret.yaml

kubectl create -f secret.yaml
kubectl create -f ingress.yaml
