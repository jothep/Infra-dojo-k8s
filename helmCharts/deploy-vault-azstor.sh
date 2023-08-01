#!/usr/bin/env bash

set -eux

if [[ -z $environment ]]; then
  echo "Should set env variable environment"
  exit 1
fi

#get and set accountName and accountKey
export "$(kubectl get secret storage-vault-secret -nmsrs -ojson|jq -r .data.storageConnectionString |base64 -d |tr ";" "\n"|grep AccountName)"
export "$(kubectl get secret storage-vault-secret -nmsrs -ojson|jq -r .data.storageConnectionString |base64 -d |tr ";" "\n"|grep AccountKey)"
export Container="sstvaultsc${environment}"

cp -rf ./vault/custom-values.yaml ./vault/${environment}-values.yaml

if [[ -z $AccountName || -z $AccountKey || -z $Container ]]; then
  echo "Should set env variable AccountName, AccountKey, Container firstly"
  exit 1
else
  echo "Already set env variable AccountName, AccountKey, Container"
  sed -i -e "s/AC_NAME/$AccountName/g;s/AC_KEY/$AccountKey/g;s/AC_CONTAINER/$Container/g" "./vault/${environment}-values.yaml"
  cat ./vault/${environment}-values.yaml
fi
