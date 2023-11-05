#!/bin/bash

echo ${CLUSTER_CONFIG} | base64 --decode > ${CLUSTER_NAME}-kind-config.yaml
