#!/bin/bash

mkdir -p /opt/kubernetes/bin
mkdir -p /opt/kubernetes/cfg
mkdir -p /opt/kubernetes/kube-cfg
mkdir -p /opt/kubernetes/pki

cp bin/* /opt/kubernetes/bin/
cp cfg/* /opt/kubernetes/cfg/
cp kube-cfg/* /opt/kubernetes/kube-cfg/
cp pki/* /opt/kubernetes/pki/

cp svc/* /lib/systemd/system/
cp ../master/pki/etcd-* /opt/kubernetes/pki/

systemctl daemon-reload

sed -i "s/hostname-override=.*/hostname-override=`hostname -f`\"/g" /opt/kubernetes/cfg/kubelet
sed -i "s/hostname-override=.*/hostname-override=`hostname -f`\"/g" /opt/kubernetes/cfg/kube-proxy
sed -i "s/iface=.*/iface=`ip addr show enp0s8 | grep -Po 'inet \K[\d.]+'`\"/g" /opt/kubernetes/cfg/flannel

COMPONENTS="flannel kube-proxy kubelet docker"

for COMPONENT in $COMPONENTS; do
	systemctl enable $COMPONENT
	systemctl start $COMPONENT
done
