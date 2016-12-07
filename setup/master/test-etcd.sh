#!/bin/bash
echo "use curl on http loopback"
#curl http://127.0.0.1:4001/v2/stats/self

echo -e "\nuse curl on https"
#curl --cacert /vagrant/setup/vault/keypair/etcd-ca.pem --cert /vagrant/setup/vault/keypair/etcd-cert.pem --key /vagrant/setup/vault/keypair/etcd-key.pem https://etcd.vm:2379/v2/stats/self

echo -e "\nuse etcdctl on http"
#etcdctl --endpoints="http://127.0.0.1:4001" --no-sync member list

echo -e "\nuse etcdctl on https"
#export ETCDCTL_CERT_FILE=/vagrant/setup/vault/keypair/etcd-cert.pem
#export ETCDCTL_KEY_FILE=/vagrant/setup/vault/keypair/etcd-key.pem
#export ETCDCTL_CA_FILE=/vagrant/setup/vault/keypair/etcd-ca.pem
#export ETCDCTL_ENDPOINTS="https://etcd.vm:2379"

etcdctl --no-sync member list
