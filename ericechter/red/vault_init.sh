#!/bin/sh

#CONFIG_OUTPUT=$(cat vault.hcl)
#export VAULT_LOCAL_CONFIG=${CONFIG_OUTPUT}
sleep 20
export VAULT_ADDR="http://${VAULT_SERVICE_SERVICE_HOST}:8200"
vault operator init -key-shares 1 -key-threshold 1 > temp.txt
UNSEALKEY=$(grep 'Unseal Key 1:' temp.txt | awk '{print $NF}')
INITKEY=$(grep 'Initial Root Token:' temp.txt | awk '{print $NF}')
vault operator unseal ${UNSEALKEY}
export VAULT_TOKEN=${INITKEY}
sleep 1000
