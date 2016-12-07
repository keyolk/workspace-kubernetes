#!/bin/bash
kubectl create -f consul-svc.yaml --namespace=kube-system
kubectl create -f consul-rc.yaml --namespace=kube-system
