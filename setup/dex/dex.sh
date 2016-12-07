#!/bin/bash

kill -9 `pidof dex`
kill -9 `pidof example-app`

dex serve config.yml &> dex.log &

sleep 1

bin/example-app \
    --client-id example-app \
    --client-secret ZXhhbXBsZS1hcHAtc2VjcmV0 \
    --issuer https://dex.local.io:5554/dex \
    --issuer-root-ca pki/dex-ca.pem \
    --tls-cert pki/dex-cert.pem \
    --tls-key pki/dex-key.pem \
    --listen http://localhost:5555 \
    --redirect-uri http://localhost:5555/callback \
    --debug \
    &> example-app.log &

echo done
