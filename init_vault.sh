#!/bin/bash
apt-get update
apt-get install -y curl
set -euo pipefail

while ! curl http://vault:8200/v1/sys/health| grep initialized; do
    echo "Waiting for vault to accept connections"
    sleep 1;
done
./vault operator init -key-shares 1 -key-threshold 1 > temp.txt
UNSEALKEY=`grep 'Unseal Key 1:' temp.txt | awk '{print $NF}'`
INITKEY=`grep 'Initial Root Token:' temp.txt | awk '{print $NF}'`
./vault operator unseal ${UNSEALKEY}
export VAULT_TOKEN=${INITKEY}
