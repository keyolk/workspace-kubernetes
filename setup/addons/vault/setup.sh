#!/bin/bash

##1. Deploy Vault
kubectl apply -f vault.yaml

## 2. Setup Vault
# 2.1 Port forward vault
#kubectl port-forward vault-... 8200
#export VAULT_ADDR=http://localhost:8200

export VAULT_ADDR=http://vault.kube-system.svc.cluster.local:8200
#export VAULT_CLIENT_CAS=

# 2.2 Set up the Root Certificate Authority
vault mount -path=root-ca -max-lease-ttl=87600h pki
vault write root-ca/root/generate/internal common_name="Root CA" ttl=87600h exclude_cn_from_sans=true
vault write root-ca/config/urls issuing_certificates="http://vault:8200/v1/root-ca/ca" crl_distribution_points="http://vault:8200/v1/root-ca/crl"

# 2.3 Create the Intermediate Certificate Authority
vault mount -path=intermediate-ca -max-lease-ttl=43800h pki
vault write intermediate-ca/intermediate/generate/internal common_name="Intermediate CA" ttl=43800h exclude_cn_from_sans=true
vault write root-ca/root/sign-intermediate csr=@intermediate.csr use_csr_values=true exclude_cn_from_sans=true
vault write intermediate-ca/intermediate/set-signed certificate=@signed.crt
vault write intermediate-ca/config/urls issuing_certificates="http://vault:8200/v1/intermediate-ca/ca" crl_distribution_points="http://vault:8200/v1/intermediate-ca/crl"
vault write intermediate-ca/roles/kubernetes-vault allow_any_name=true max_ttl="24h"

# 2.4 Enable the AppRole backend
vault auth-enable approle
vault write auth/approle/role/sample-app secret_id_ttl=90s period=6h secret_id_num_uses=1

# 2.5 Create token role for kubernetes-vault
vault policy-write kubernetes-vault policy.hcl
vault write auth/token/roles/kubernetes-vault allowed_policies=kubernetes-vault period=6h

# 2.6 Generate the token for kubernetes-vault and AppID
vault token-create -role=kubernetes-vault
vault read auth/approle/role/sample-app/role-id

## 3. Deploy kubernetes-vault
kubectl apply -f kubernetes-vault.yaml

## 4. Deploy a sample app
kubectl apply -f sample-app.yaml

## 5. Confirm 
kubectl logs mypod

## 6. Tear down
kubectl apply -f deployments/sample-app.yaml
kubectl delete -f deployments/sample-app.yaml -f deployments/kubernetes-vault.yaml
