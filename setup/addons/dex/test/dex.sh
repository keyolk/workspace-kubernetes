#!/bin/bash
curl -v --cacert ../../../dex/pki/dex-ca.pem https://kube-1.local.io:30443/.well-known/openid-configuration
