#!/bin/bash

kubectl config set-cluster vagrant \
		--server=https://kube-apiserver.local.io \
		--certificate-authority=/opt/kubernetes/pki/kube-ca.pem

kubectl config set-credentials keyolk \
	--certificate-authority=/opt/kubernetes/pki/kube-ca.pem \
	--client-key=/opt/kubernetes/pki/kube-admin-key.pem \
	--client-certificate=/opt/kubernetes/pki/kube-admin-cert.pem

kubectl config set-context vagrant --cluster=vagrant --user=keyolk --namespace=default
kubectl config use-context vagrant
