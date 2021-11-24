# Usage

## UI based install 

```shell
    helm upgrade --install [RELEASE_NAME] . --namespace [NAMESPACE] --create-namespace --set kotsadm.kotsadmPassword=[KOTSADM_PASSWORD]
    kubectl port-forward -n [NAMESPACE] svc/kotsadm 8800:3000
```

## Automation

If you want to automatically install the kots license, you can do so by setting the following 2 values:

* `kotsadm.license.slug`: The application slug for the application you're installing. For example: `sentry-pro`
* `kotsadm.license.data`: The license yaml content.

```shell
    helm upgrade --install [RELEASE_NAME] . --namespace [NAMESPACE] --create-namespace \
        --set kotsadm.kotsadmPassword=[KOTSADM_PASSWORD] \
        --set kotsadm.license.slug=[APP_SLUG] \
        --set kotsadm.liccense.data="$(cat [PATH_TO_LICENSE_YAML])"
    kubectl port-forward -n [NAMESPACE] svc/kotsadm 8800:3000
```

