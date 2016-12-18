#!/bin/bash
function curl_secret(){
  curl -L -v \
    -ca=tls.ca.crt -cert=tls.crt -key=tls.key \
    -X GET \
    -H "X-Vault-Token: vault-root-token" \
    https://localhost:8400/v1/secret\?list\=true
}

export VAULT_ADDR=https://localhost:8400
export VAULT_CACERT=tls.ca.crt
export VAULT_CLIENT_CERT=tls.crt
export VAULT_CLIENT_KEY=tls.key
