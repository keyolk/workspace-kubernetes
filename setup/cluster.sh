#!/bin/bash
WORKDIR=/home/keyolk/kubernetes

kubectl config set-cluster vagrant \
		--server=https://kube-apiserver.local.io \
		--certificate-authority=$WORKDIR/setup/master/pki/kube-ca.pem

kubectl config set-credentials keyolk \
	--certificate-authority=$WORKDIR/setup/master/pki/kube-ca.pem \
	--client-key=$WORKDIR/setup/master/pki/kube-admin-key.pem \
	--client-certificate=$WORKDIR/setup/master/pki/kube-admin-cert.pem

kubectl config set-context vagrant --cluster=vagrant --user=keyolk --namespace=default
kubectl config use-context vagrant
