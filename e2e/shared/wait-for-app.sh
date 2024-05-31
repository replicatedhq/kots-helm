#!/bin/bash

set -e

appSlug=$1

COUNTER=1
while [ "$(kubectl kots get apps --namespace "$appSlug" | awk 'NR>1{print $2}')" != "ready" ]; do
  ((COUNTER += 1))
  if [ $COUNTER -gt 120 ]; then
    echo "Timed out waiting for app to be ready"
    kubectl kots get apps --namespace "$appSlug"
    echo "kotsadm logs:"
    kubectl logs -l app=kotsadm --tail=100 --namespace "$appSlug"
    exit 1
  fi
  sleep 1
done
