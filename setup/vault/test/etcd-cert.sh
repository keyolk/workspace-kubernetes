#!/bin/bash
openssl x509 -in ../keypair/etcd-ca.pem -text -noout
openssl x509 -in ../keypair/etcd-cert.pem -text -noout
