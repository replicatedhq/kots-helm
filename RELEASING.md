# Creating a staging release

Staging Helm chart of this repo can be created by pushing a version tag with `-alpha` pre-release value.
The version of the chart must match some version of KOTS.
For example:

```shell
    git tag v1.76.0-alpha
```

Multiple versions of the chart can be created for the same version of KOTS by adding a numeric identifier.
For example:

```shell
    git tag v1.76.0-alpha.2
```

# Creating a production release

Staging Helm chart of this repo can be created by pushing a version tag.
The version of the chart must match the latest version of KOTS.
For example:

```shell
    git tag v1.76.0
```

Multiple versions of the chart can be created for the same version of KOTS by build suffix with a numeric identifier.
For example:

```shell
    git tag v1.76.0-build.2
```
