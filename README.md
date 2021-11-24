# Intro

**Note**: This is not an officially supported way of installing kots. If you're looking for using this in a supported way, check the [kots documentation](https://kots.io/kotsadm/installing/installing-a-kots-app/)


This helm chart allows installing a Replicated kots application by installing kostadm, and automating the install process using helm values.



# Usage

## UI based install 

```shell
    helm upgrade --install [RELEASE_NAME] . --namespace [NAMESPACE] --create-namespace --set kotsadm.kotsadmPassword=[KOTSADM_PASSWORD]
    kubectl port-forward -n [NAMESPACE] svc/kotsadm 8800:3000
```

## Automation

If you want to automatically install the kots license, you can do so by setting the following 2 values:

* `kotsadm.automation.license.slug`: The application slug for the application you're installing. For example: `sentry-pro`
* `kotsadm.automation.license.data`: The license yaml content.

```shell
    helm upgrade --install [RELEASE_NAME] . --namespace [NAMESPACE] --create-namespace \
        --set kotsadm.kotsadmPassword=[KOTSADM_PASSWORD] \
        --set kotsadm.license.slug=[APP_SLUG] \
        --set kotsadm.liccense.data="$(cat [PATH_TO_LICENSE_YAML])"
    kubectl port-forward -n [NAMESPACE] svc/kotsadm 8800:3000
```

If you want to skip pre-flights, you can do so by setting the following value:
* `kotsadm.automation.skipPreflights` (default: `false`)