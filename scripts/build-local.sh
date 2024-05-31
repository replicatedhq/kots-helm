#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <kots-tag>"
  exit 1
fi

export KOTS_TAG=$1
export KOTSADM_REGISTRY=kotsadm # docker.io is implicit
export CHART_VERSION=${KOTS_TAG#v}

curl -O -L https://raw.githubusercontent.com/replicatedhq/kots/"${KOTS_TAG}"/.image.env
export $(cat .image.env | sed 's/#.*//g' | xargs)

envsubst < Chart.yaml.tmpl > Chart.yaml
envsubst < values.yaml.tmpl > values.yaml

rm -f admin-console-*.tgz
helm package .
rm -f Chart.yaml values.yaml .image.env