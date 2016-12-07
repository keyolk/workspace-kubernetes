#!/bin/bash
COMPONENTS="flannel kubelet kube-proxy docker"

for COMPONENT in $COMPONENTS; do
  systemctl start $COMPONENT
done
