#!/bin/bash

set -e

GIT_COMMIT=$1
export CHART_VERSION=0.0.0-${GIT_COMMIT}
export KOTS_VERSION=24h
export KOTS_TAG=24h
export KOTSADM_REGISTRY=ttl.sh/$USER

curl -O -L https://raw.githubusercontent.com/replicatedhq/kots/${GIT_COMMIT}/.image.env
export $(cat .image.env | sed 's/#.*//g' | xargs)

envsubst < Chart.yaml.tmpl > Chart.yaml
envsubst < values.yaml.tmpl > values.yaml

rm -f admin-console-*.tgz
export CHART_NAME=`helm package . | rev | cut -d/ -f1 | rev`
helm push $CHART_NAME oci://ttl.sh/$USER

rm -f Chart.yaml values.yaml .image.env
