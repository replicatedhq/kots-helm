# Intro

**Note**: This is not an officially supported way of installing kots. If you're looking for using this in a supported way, check the [kots documentation](https://kots.io/kotsadm/installing/installing-a-kots-app/)

This helm chart allows installing and configuring KOTS via Helm.

# Usage

## UI based install 

```shell
    helm upgrade --install [RELEASE_NAME] . --namespace [NAMESPACE] --create-namespace --set password=[KOTSADM_PASSWORD]
    kubectl port-forward -n [NAMESPACE] svc/kotsadm 8800:3000
```

## Local dev

Run build-local.sh script located in the scripts directory of this repository to create a chart.
The input parameter is the kots version to package

```
./scripts/build-local.sh 1.75.0
```

To build a chart that uses ttl images, run the build-ttl.sh script located in the scripts directory.
The input parameter is the commit sha that matches that of the kots ttl images that were pushed.
```
./scripts/build-ttl.sh 3db5e3c
```
