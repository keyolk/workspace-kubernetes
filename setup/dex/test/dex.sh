#!/bin/bash
curl -v --cacert ../pki/dex-ca.pem https://laptop.local.io:5554/dex/.well-known/openid-configuration
