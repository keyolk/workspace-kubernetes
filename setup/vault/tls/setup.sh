#!/bin/bash

# Generate a CA
openssl req -x509 -nodes -new \
  -newkey rsa:4096 \
  -days 365 \
  -subj "/C=US/ST=WA/L=Seattle/O=SamsungSDS/CN=localhost" \
  -keyout tls.ca.key \
  -out tls.ca.crt

# Generate a server keypair
openssl genrsa -out tls.key 1024
openssl req \
  -new \
  -key tls.key \
  -subj "/C=US/ST=WA/L=Seattle/O=SamsungSDS/CN=localhost" \
  -out tls.req

echo "00" > tls.srl

openssl x509 -req \
  -in tls.req \
  -CA tls.ca.crt \
  -CAkey tls.ca.key \
  -CAserial tls.srl \
  -out tls.crt

kill -9 `pidof vault`
#generate a client keypair
#openssl req -new -key client.key -out client.req
#openssl x509 -req -in client.req -CA tls.ca.crt -CAkey tls.ca.key -CAserial tls.srl -out client.crt

vault server -config=policy.hcl &> vault.log &

export VAULT_ADDR=https://localhost:8400
export VAULT_CACERT=tls.ca.crt
export VAULT_CLIENT_CERT=tls.crt
export VAULT_CLIENT_KEY=tls.key

vault init | tee vault.key
