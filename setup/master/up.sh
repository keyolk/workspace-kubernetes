#!/bin/bash

sed -i "s/advertise-address=.*/advertise-address=`ip addr show enp0s8 | grep -Po 'inet \K[\d.]+'`\"/g" /opt/kubernetes/cfg/kube-apiserver

COMPONENTS="etcd kube-apiserver kube-controller-manager kube-scheduler"

for COMPONENT in $COMPONENTS; do
  systemctl start $COMPONENT
done
