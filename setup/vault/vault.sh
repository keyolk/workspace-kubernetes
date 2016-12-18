#!/bin/bash

kill -9 `pidof vault`
kill -9 `pidof consul-template`

sleep 1

vault server -dev &> logs/vault.log &

sleep 1

export VAULT_ADDR=http://localhost:8200

vault mount -max-lease-ttl=87600h -path vagrant/pki/etcd pki
vault mount -max-lease-ttl=87600h -path vagrant/pki/dex pki
vault mount -max-lease-ttl=87600h -path vagrant/pki/keycloak pki
vault mount -max-lease-ttl=87600h -path vagrant/pki/kube pki

vault write vagrant/pki/etcd/root/generate/internal common_name=vagrant/pki/etcd ttl=87600h
vault write vagrant/pki/dex/root/generate/internal common_name=vagrant/pki/dex ttl=87600h
vault write vagrant/pki/keycloak/root/generate/internal common_name=vagrant/pki/keycloak ttl=87600h
vault write vagrant/pki/kube/root/generate/internal common_name=vagrant/pki/kube ttl=87600h

vault write vagrant/pki/etcd/roles/member \
  allow_any_name="true" \
  max_ttl="720h"

vault write vagrant/pki/dex/roles/member \
  allow_any_name="true" \
  max_ttl="720h" 

vault write vagrant/pki/keycloak/roles/member \
  allow_any_name="true" \
  max_ttl="720h" 

vault write vagrant/pki/kube/roles/kube-apiserver \
  allow_any_name="true" \
  max_ttl="720h"

COMPONENTS="kube-controller-manager kube-scheduler kubelet kube-proxy kube-admin"

for COMPONENT in $COMPONENTS; do
  vault write vagrant/pki/kube/roles/$COMPONENT \
    allowed_domains="$COMPONENT"    \
    allow_bare_domains="true"       \
    allow_subdomain="false"         \
    max_ttl="720h"
done

openssl genrsa 4096 > token-key
vault write secret/vagrant/kube/token key=@token-key
rm token-key

cat <<EOT | vault policy-write vagrant/pki/etcd/member -
path "vagrant/pki/etcd/issue/member" {
  policy = "write"
}
EOT

cat <<EOT | vault policy-write vagrant/pki/dex/member -
path "vagrant/pki/dex/issue/member" {
  policy = "write"
}
EOT

cat <<EOT | vault policy-write vagrant/pki/keycloak/member -
path "vagrant/pki/keycloak/issue/member" {
  policy = "write"
}
EOT

cat <<EOT | vault policy-write vagrant/pki/kube/kube-apiserver -
path "vagrant/pki/kube/issue/kube-apiserver" {
  policy = "write"
}
EOT

cat <<EOT | vault policy-write vagrant/pki/kube/kube-controller-manager -
path "vagrant/pki/kube/issue/kube-controller-manager" {
  policy = "write"
}
EOT

cat <<EOT | vault policy-write vagrant/pki/kube/kube-scheduler -
path "vagrant/pki/kube/issue/kube-scheduler" {
  policy = "write"
}
EOT

cat <<EOT | vault policy-write vagrant/pki/kube/kubelet -
path "vagrant/pki/kube/issue/kubelet" {
  policy = "write"
}
EOT

cat <<EOT | vault policy-write vagrant/pki/kube/kube-proxy -
path "vagrant/pki/kube/issue/kube-proxy" {
  policy = "write"
}
EOT

cat <<EOT | vault policy-write vagrant/pki/kube/kube-admin -
path "vagrant/pki/kube/issue/kube-admin" {
  policy = "write"
}
EOT

vault write auth/token/roles/kube-vagrant \
period="720h" \
orphan=true   \
allowed_policies="vagrant/pki/etcd/member, \
vagrant/pki/dex/member, \
vagrant/pki/keycloak/member, \
vagrant/pki/kube/kube-apiserver, \
vagrant/pki/kube/kube-controller-manager, \
vagrant/pki/kube/kube-scheduler, \
vagrant/pki/kube/kubelet, \
vagrant/pki/kube/kube-proxy, \
vagrant/pki/kube/kube-admin"

vault token-create \
  -policy="vagrant/pki/etcd/member" \
  -policy="vagrant/pki/dex/member" \
  -policy="vagrant/pki/keycloak/member" \
  -policy="vagrant/pki/kube/kube-apiserver" \
  -policy="vagrant/pki/kube/kube-controller-manager" \
  -policy="vagrant/pki/kube/kube-scheduler" \
  -policy="vagrant/pki/kube/kubelet" \
  -policy="vagrant/pki/kube/kube-proxy" \
  -policy="vagrant/pki/kube/kube-admin" \
  -role="kube-vagrant" | tee token

TOKEN=`cat token | grep "token " | awk '{print $2}'`
rm token

sed -i "s/\"token.*/\"token\": \"${TOKEN}\",/g" consul-template.cfg

consul-template -config=consul-template.cfg &> logs/consul-template.log &

echo "done!"
