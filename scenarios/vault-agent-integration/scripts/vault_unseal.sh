#!/usr/bin/env bash

set -euo pipefail
# set -x

VAULT_URL=$1

VAULT_STATUS=$(curl -sX GET ${VAULT_URL}/v1/sys/seal-status)
IS_INITIALIZED=$(echo ${VAULT_STATUS} | jq '.initialized')
IS_SEALED=$(echo ${VAULT_STATUS} | jq '.sealed')

THRESHOLD=$(echo ${VAULT_STATUS} | jq -r '.t')

if [[ "$IS_INITIALIZED" == "false" ]]; then
  echo "Vault is not yet initialized. Please initialize it first";
fi

if [[ "$IS_SEALED" == "false" ]]; then
  echo "Vault is not yet sealed";
else
  for IDX in $(seq 0 $(( THRESHOLD - 1 ))); do
    KEY=$(cat creds.json | jq -r ".keys[${IDX}]")
    curl -sfX POST -d "{\"key\": \"${KEY}\"}" ${VAULT_URL}/v1/sys/unseal
  done
fi
