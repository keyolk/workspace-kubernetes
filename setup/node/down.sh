#!/bin/bash
COMPONENTS="flannel kubelet kube-proxy"

for COMPONENT in $COMPONENTS; do
  systemctl stop $COMPONENT
done
