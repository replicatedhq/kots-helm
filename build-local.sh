#!/bin/bash

set -e

export CURRENT_USER=`id -u -n`
export KOTS_VERSION=$1
export KOTS_TAG=v${KOTS_VERSION}
export CHART_VERSION=${KOTS_VERSION}

curl -O -L https://raw.githubusercontent.com/replicatedhq/kots/${KOTS_TAG}/.image.env

export $(cat .image.env | sed 's/#.*//g' | xargs)
# Postgres tag variable was changed after 1.77.0 release
if [ -z "$POSTGRES_ALPINE_TAG" ] && [ -n "$POSTGRES_14_TAG" ]; then
    export POSTGRES_ALPINE_TAG=${POSTGRES_14_TAG}
fi

envsubst < Chart.yaml.tmpl > Chart.yaml
envsubst < values.yaml.tmpl > values.yaml

export CHART_NAME=`helm package . | rev | cut -d/ -f1 | rev`
helm push $CHART_NAME oci://ttl.sh/${CURRENT_USER}

rm -f Chart.yaml values.yaml .image.env