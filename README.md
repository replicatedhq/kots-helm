# Usage

```shell
    helm upgrade --install [RELEASE_NAME] . --namespace [NAMESPACE] --create-namespace --set global.kotsadm.kotsadmPassword=[KOTSADM_PASSWORD]
    kubectl port-forward -n [NAMESPACE] svc/kotsadm 8800:3000
```

