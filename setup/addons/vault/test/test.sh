#!/bin/bash
export VAULT_ADDR=https://kube-1.local.io:32443
export VAULT_CACERT=/home/keyolk/kubernetes/setup/vault/pki/vault-ca-cert.pem
export VAULT_CLIENT_CERT=/home/keyolk/kubernetes/setup/vault/pki/vault-cert.pem
export VAULT_CLIENT_KEY=/home/keyolk/kubernetes/setup/vault/pki/vault-key.pem

vault init
vault status
