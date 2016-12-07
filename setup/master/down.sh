#!/bin/bash
COMPONENTS="etcd kube-apiserver kube-controller-manager kube-scheduler"

for COMPONENT in $COMPONENTS; do
  systemctl stop $COMPONENT
done
