#!/bin/bash
SETUP_HOME=/home/keyolk/kubernetes/setup
VAUTL_CERT="$SETUP_HOME/vault/pki/vault-cert.pem"
VAULT_KEY="$SETUP_HOME/vault/pki/vault-key.pem"

VAULT_CERT_TEXT=`cat /home/keyolk/mount/flash/workspace/vagrant/kubernetes/setup/vault/pki/vault-cert.pem | base64 -w 10000`
VAULT_KEY_TEXT=`cat /home/keyolk/mount/flash/workspace/vagrant/kubernetes/setup/vault/pki/vault-key.pem | base64 -w 10000`

sed -i "s/vault.crt:.*/vault.crt: $VAULT_CERT_TEXT/g" vault.yaml
sed -i "s/vault.key:.*/vault.key: $VAULT_KEY_TEXT/g" vault.yaml
