#!/bin/bash

NAMESPACE=${NAMESPACE:-default}

check_secret_exists() {
  if kubectl get secret $1 -n $NAMESPACE >/dev/null 2>&1; then
    echo "Kubernetes secret $1 already exists in namespace $NAMESPACE, exiting..."
    return 1
  fi
}

create_secret() {
  local secret_name=$1
  local secret_data=""
  shift
  while (( "$#" )); do
    local env_value=${!1:-}
    if [[ -n $env_value ]]; then
      secret_data+="--from-literal=$1=$env_value "
    fi
    shift
  done
  kubectl create secret generic $secret_name $secret_data -n $NAMESPACE

  echo "Kubernetes secret $secret_name created in namespace $NAMESPACE"
}

# Usage: ./script.sh my-secret-name ENV_VAR_1 ENV_VAR_2 ...
secret_name=$1
if check_secret_exists $secret_name; then
  create_secret "$@"
fi