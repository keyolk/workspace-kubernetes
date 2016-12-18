#!/bin/bash

function auth-github {
  vault auth-enable github
  vault write auth/github/config organization=samsung-cnct
  vault write auth/github/map/teams/default value=default
  vault auth -method=github token="7d97285fe38d2c246f57cc1cf75151ec30c41939"
}

function auth-approle {
  vault auth-enable approle
  vault write auth/approle/role/admin secret_id_ttl=10m token_ttl=20m token_max_ttl=30m secret_id_num_uses=40

  roleId=`vault read auth/approle/role/admin/role-id | grep role_id | awk '{print $2}'`
  secretId=`vault write -f auth/approle/role/admin/secret-id | grep "secret_id " | awk '{print $2}'`

  token=`vault write auth/approle/login role_id=12f5c759-d8ff-efb1-a44f-25ba22f02a6d secret_id=9de6193f-9b3f-9bab-3527-ef03b01613e3 | grep "token " | awk '{print $2}'`

  vault auth $token
}

function token-create {
  vault token-create
}

case $2 in
  auth-approle )
    vault auth vault-root-token
    auth-approle
    ;;
  auth-github )
    vault auth vault-root-token
    auth-github
    ;;
  token-create )
    vault auth vault-root-token
    token-create
    ;;
  * )
    echo "command : auth-git auth-approle token-create"
    ;;
esac
