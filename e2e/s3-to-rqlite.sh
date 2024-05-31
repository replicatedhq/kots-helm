#!/bin/bash

set -e

# 1.107.8 is the latest version of the chart that uses s3
helm install s3-to-rqlite oci://registry.replicated.com/library/admin-console \
  --version 1.107.8 \
  --namespace s3-to-rqlite \
  --create-namespace \
  --set password=password \
  --set isHelmManaged=false \
  --wait

# download KOTS CLI
curl -LO "https://github.com/replicatedhq/kots/releases/latest/download/kots_linux_amd64.tar.gz" \
  && tar zxvf kots_linux_amd64.tar.gz \
  && mv kots /usr/local/bin/kubectl-kots

# install the app
echo "$LICENSE_BASE64" | base64 -d > license.yaml
kubectl kots install s3-to-rqlite \
  --namespace s3-to-rqlite \
  --shared-password=password \
  --license-file=license.yaml

# wait for the app to be ready
./shared/wait-for-app.sh s3-to-rqlite

# upgrade the chart
helm upgrade -i s3-to-rqlite "$CHART_URL" \
  --version "$CHART_VERSION" \
  --namespace s3-to-rqlite \
  --wait

# validate migration success
if ! kubectl logs -n s3-to-rqlite job/kotsadm-migrate-s3-to-rqlite | grep -q "Migrated from S3 to rqlite successfully!"; then
  echo "Migration failed"
  kubectl logs -n s3-to-rqlite job/kotsadm-migrate-s3-to-rqlite
  exit 1
fi
