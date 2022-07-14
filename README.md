# Intro

**Note**: This is not an officially supported way of installing kots. If you're looking for using this in a supported way, check the [kots documentation](https://kots.io/kotsadm/installing/installing-a-kots-app/)


This helm chart allows installing a Replicated kots application by installing kostadm, and automating the install process using helm values.



# Usage

## UI based install 

```shell
    helm upgrade --install [RELEASE_NAME] . --namespace [NAMESPACE] --create-namespace --set adminConsole.password=[KOTSADM_PASSWORD]
    kubectl port-forward -n [NAMESPACE] svc/kotsadm 8800:3000
```

## Automation

If you want to automatically install the kots license, you can do so by setting the following 2 values:

* `adminConsole.automation.license.slug`: The application slug for the application you're installing. For example: `sentry-pro`
* `adminConsole.automation.license.data`: The license yaml content.

```shell
    helm upgrade --install [RELEASE_NAME] . --namespace [NAMESPACE] --create-namespace \
        --set adminConsole.password=[KOTSADM_PASSWORD] \
        --set adminConsole.automation.license.slug=[APP_SLUG] \
        --set adminConsole.automation.license.data="$(cat [PATH_TO_LICENSE_YAML])"
    kubectl port-forward -n [NAMESPACE] svc/kotsadm 8800:3000
```

If you want to skip pre-flights, you can do so by setting the following value:
* `adminConsole.automation.skipPreflights` (default: `false`)

If you want to specify ConfigValues, you can do so by setting the `adminConsole.automation.config.values`:

```shell
    helm upgrade --install [RELEASE_NAME] . --namespace [NAMESPACE] --create-namespace \
        --set adminConsole.password=[KOTSADM_PASSWORD] \
        --set adminConsole.automation.license.slug=[APP_SLUG] \
        --set adminConsole.automation.license.data="$(cat [PATH_TO_LICENSE_YAML])" \
        --set adminConsole.automation.config.values="$(cat [PATH_TO_CONFIG_YAML])"
    kubectl port-forward -n [NAMESPACE] svc/kotsadm 8800:3000
```

## Local dev

Run build-local.sh script located in the root directory of this repository to create a chart.
The input parameter is the kots version to package

```
./build-local.sh 1.75.0
```