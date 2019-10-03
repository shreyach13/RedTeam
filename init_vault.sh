#!/bin/sh
apt-get update
apt-get install unzip
unzip vault_1.2.3_linux_amd64.zip
apt-get update
apt-get install -y curl
#set -euo pipefail

#unzip vault_1.2.3_linux_amd64.zip /vault

while ! curl http://vaultapp.shreyaspace:8200/v1/sys/health| grep initialized; do
    echo "Waiting for vault to accept connections"
    sleep 1;
done
#sleep 50
cp /vault/vault /usr/local/bin
vault operator init -key-shares 1 -key-threshold 1 > temp.txt
UNSEALKEY=`grep 'Unseal Key 1:' temp.txt | awk '{print $NF}'`
INITKEY=`grep 'Initial Root Token:' temp.txt | awk '{print $NF}'`
vault operator unseal ${UNSEALKEY}
export VAULT_TOKEN=${INITKEY}

sleep 1000
