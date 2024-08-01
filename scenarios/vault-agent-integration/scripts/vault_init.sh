#!/usr/bin/env bash

set -euo pipefail
# set -x

VAULT_URL=$1
SHARES=$2
THRESHOLD=$3

VAULT_STATUS=$(curl -sX GET ${VAULT_URL}/v1/sys/seal-status)
IS_INITIALIZED=$(echo ${VAULT_STATUS} | jq '.initialized')

if [[ "$IS_INITIALIZED" == "true" ]]; then
  echo "Vault is already initialized";
else
  curl -sfX POST -d "{\"secret_shares\": ${SHARES}, \"secret_threshold\": ${THRESHOLD}}" -o creds.json ${VAULT_URL}/v1/sys/init;
  echo "Vault initialized"
  echo "Creds are stored in 'creds.json'"
fi
