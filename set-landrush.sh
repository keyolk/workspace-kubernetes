#!/bin/bash
vagrant landrush set kube-apiserver.local.io kube-1.local.io
vagrant landrush set etcd.local.io kube-1.local.io
vagrant landrush set laptop.local.io 172.28.128.1
