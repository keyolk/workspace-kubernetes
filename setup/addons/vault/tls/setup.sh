#!/bin/bash
openssl req -x509 -nodes -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=vault.kube-system.svc.cluster.io"

echo "
apiVersion: v1
kind: Secret
metadata:
  name: vault-secret
data:
  tls.crt: `base64 -w 10000 tls.crt`
  tls.key: `base64 -w 10000 tls.key`
" > vault-secret.yaml
