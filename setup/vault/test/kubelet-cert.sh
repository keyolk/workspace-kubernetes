#!/bin/bash
openssl x509 -in ../keypair/kube-ca.pem -text -noout
openssl x509 -in ../keypair/kubelet-cert.pem -text -noout
