#!/bin/bash

mkdir -p /opt/kubernetes/bin
mkdir -p /opt/kubernetes/cfg
mkdir -p /opt/kubernetes/kube-cfg
mkdir -p /opt/kubernetes/pki

mkdir -p /var/lib/etcd

cp bin/*     /opt/kubernetes/bin/
cp cfg/*     /opt/kubernetes/cfg/
cp kube-cfg/* /opt/kubernetes/kube-cfg/
cp pki/*     /opt/kubernetes/pki/

chown -R vagrant:vagrant /opt/kubernetes/pki/

cp svc/*     /lib/systemd/system/

cp ../dex/pki/dex-ca.pem /opt/kubernetes/pki/

ln -sf /opt/kubernetes/bin/kubectl /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl

systemctl daemon-reload

sed -i "s/advertise-address=.*/advertise-address=`ip addr show enp0s8 | grep -Po 'inet \K[\d.]+'`\"/g" /opt/kubernetes/cfg/kube-apiserver

COMPONENTS="etcd kube-apiserver kube-controller-manager kube-scheduler"

for COMPONENT in $COMPONENTS; do
  systemctl enable $COMPONENT
  systemctl start $COMPONENT
done

/opt/kubernetes/bin/etcdctl --no-sync mk /coreos.com/network/config "{\"Network\":\"172.16.0.0/16\"}" 
