#!/bin/bash

sed -i "s/iface=.*/iface=`ip addr show enp0s8 | grep -Po 'inet \K[\d.]+'`\"/g" /opt/kubernetes/cfg/flannel

COMPONENTS="flannel kubelet kube-proxy docker"

for COMPONENT in $COMPONENTS; do
  systemctl start $COMPONENT
done
