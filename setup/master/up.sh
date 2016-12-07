#!/bin/bash
COMPONENTS="etcd kube-apiserver kube-contoller-manager kube-scheduler"

for COMPONENT in $COMPONENTS; do
  systemctl start $COMPONENT
done
