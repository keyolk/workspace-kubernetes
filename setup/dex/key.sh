#!/bin/bash

mkdir -p pki

cat << EOF > pki/dex-req.cnf
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name

[req_distinguished_name]

[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = laptop.local.io
EOF

openssl genrsa -out pki/dex-ca-key.pem 2048
openssl req -x509 -new -nodes -key pki/dex-ca-key.pem -days 10 -out pki/dex-ca.pem -subj "/CN=kube-ca"

openssl genrsa -out pki/dex-key.pem 2048
openssl req -new -key pki/dex-key.pem -out pki/dex-csr.pem -subj "/CN=kube-ca" -config pki/dex-req.cnf
openssl x509 -req -in pki/dex-csr.pem -CA pki/dex-ca.pem -CAkey pki/dex-ca-key.pem -CAcreateserial -out pki/dex-cert.pem -days 10 -extensions v3_req -extfile pki/dex-req.cnf

