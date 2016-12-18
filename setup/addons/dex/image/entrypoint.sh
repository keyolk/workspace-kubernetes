#!/bin/sh

: ${DEX_ISSUER?" is empty string"}
: ${DEX_APP_LISTEN_ADDRESS?" is empty string"}
: ${DEX_APP_REDIRECT_URI?" is empty string"}
: ${DEX_CA?" is empty string"}
: ${DEX_CERT?" is empty string"}
: ${DEX_KEY?" is empty string"}

DEX_APP_CLIENT_ID=${DEX_APP_CLIENT_ID:-example-app}
DEX_APP_CLIENT_SECRET=${DEX_APP_CLIENT_SECRET:-ZXhhbXBsZS1hcHAtc2VjcmV0}

/usr/local/bin/example-app \
  --client-id $DEX_APP_CLIENT_ID \
  --client-secret $DEX_APP_CLIENT_SECRET \
  --issuer $DEX_ISSUER \
  --issuer-root-ca $DEX_CA \
  --tls-cert $DEX_CERT \
  --tls-key $DEX_KEY \
  --listen $DEX_APP_LISTEN_ADDRESS \
  --redirect-uri $DEX_APP_REDIRECT_URI \
  --debug 
