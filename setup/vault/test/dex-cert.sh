#!/bin/bash
openssl x509 -in ../../dex/pki/dex-ca.pem -text -noout
openssl x509 -in ../../dex/pki/dex-cert.pem -text -noout
