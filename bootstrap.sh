#!/bin/bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y docker.io socat
usermod -a -G docker vagrant

if [ ! -d /vagrant/kubernetes  ]; 
then
  cd /vagrant
  wget https://github.com/kubernetes/kubernetes/releases/download/v1.4.6/kubernetes.tar.gz
  #wget https://github.com/kubernetes/kubernetes/releases/download/v1.5.0-beta.1/kubernetes.tar.gz

  tar xvzf kubernetes.tar.gz
  /vagrant/kubernetes/cluster/ubuntu/download-release.sh
  cp /vagrant/kubernetes/cluster/ubuntu/binaries/kubectl /vagrant/setup/master/bin/
  cp /vagrant/kubernetes/cluster/ubuntu/binaries/master/* /vagrant/setup/master/bin/
  cp /vagrant/kubernetes/cluster/ubuntu/binaries/minion/* /vagrant/setup/node/bin/
  rm kubernetes.tar.gz
fi
